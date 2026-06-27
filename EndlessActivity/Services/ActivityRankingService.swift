import Foundation

struct ActivityRankingService: Sendable {
    func rankedActivities(
        catalog: [Activity],
        preferences: ActivityPreferences,
        savedIDs: Set<String>,
        skippedIDs: Set<String>,
        sessionSeed: UInt64 = 0
    ) -> [Activity] {
        let savedActivities = catalog.filter { savedIDs.contains($0.id) }
        let savedCategories = Set(savedActivities.map(\.category))
        let savedTags = Set(savedActivities.flatMap(\.tags))

        return catalog
            .filter {
                !savedIDs.contains($0.id) && !skippedIDs.contains($0.id) &&
                    isEligible($0, preferences: preferences)
            }
            .map { activity in
                (
                    activity: activity,
                    score: score(
                        activity,
                        preferences: preferences,
                        savedCategories: savedCategories,
                        savedTags: savedTags
                    ),
                    tieBreak: stableValue(for: activity.id, seed: sessionSeed)
                )
            }
            .sorted {
                if $0.score != $1.score { return $0.score > $1.score }
                if $0.tieBreak != $1.tieBreak { return $0.tieBreak < $1.tieBreak }
                return $0.activity.id < $1.activity.id
            }
            .map(\.activity)
    }

    func isEligible(_ activity: Activity, preferences: ActivityPreferences) -> Bool {
        if !preferences.selectedCategories.isEmpty,
           !preferences.selectedCategories.contains(activity.category) { return false }
        if let maxDuration = preferences.maxDurationMinutes,
           activity.durationMinutes > maxDuration { return false }
        if !preferences.allowedCostLevels.isEmpty,
           !preferences.allowedCostLevels.contains(activity.costLevel) { return false }
        if !preferences.allowedEnergyLevels.isEmpty,
           !preferences.allowedEnergyLevels.contains(activity.energyLevel) { return false }
        if !preferences.allowedSettings.isEmpty,
           activity.setting != .either,
           !preferences.allowedSettings.contains(activity.setting) { return false }
        if !preferences.allowedSocialModes.isEmpty,
           activity.socialMode != .any,
           !preferences.allowedSocialModes.contains(activity.socialMode) { return false }
        return true
    }

    private func score(
        _ activity: Activity,
        preferences: ActivityPreferences,
        savedCategories: Set<ActivityCategory>,
        savedTags: Set<String>
    ) -> Int {
        var result = 0
        if preferences.selectedCategories.contains(activity.category) { result += 20 }
        if preferences.maxDurationMinutes != nil { result += 4 }
        if preferences.allowedCostLevels.contains(activity.costLevel) { result += 4 }
        if preferences.allowedEnergyLevels.contains(activity.energyLevel) { result += 4 }
        if preferences.allowedSettings.contains(activity.setting) || activity.setting == .either { result += 4 }
        if preferences.allowedSocialModes.contains(activity.socialMode) || activity.socialMode == .any { result += 4 }
        if savedCategories.contains(activity.category) { result += 6 }
        result += min(Set(activity.tags).intersection(savedTags).count * 2, 8)
        if preferences.allowedCostLevels.isEmpty, activity.costLevel == .high { result -= 6 }
        if preferences.maxDurationMinutes == nil, activity.durationMinutes > 60 { result -= 4 }
        if preferences.allowedSocialModes.isEmpty, activity.socialMode == .group { result -= 3 }
        return result
    }

    private func stableValue(for string: String, seed: UInt64) -> UInt64 {
        string.utf8.reduce(1_469_598_103_934_665_603 ^ seed) { value, byte in
            (value ^ UInt64(byte)) &* 1_099_511_628_211
        }
    }
}
