import Foundation

struct ActivityPreferences: Codable, Equatable, Sendable {
    var selectedCategories: Set<ActivityCategory> = []
    var maxDurationMinutes: Int?
    var allowedCostLevels: Set<CostLevel> = []
    var allowedEnergyLevels: Set<EnergyLevel> = []
    var allowedSettings: Set<ActivitySetting> = []
    var allowedSocialModes: Set<SocialMode> = []

    static let defaults = ActivityPreferences()

    var hasActiveFilters: Bool {
        !selectedCategories.isEmpty || maxDurationMinutes != nil ||
            !allowedCostLevels.isEmpty || !allowedEnergyLevels.isEmpty ||
            !allowedSettings.isEmpty || !allowedSocialModes.isEmpty
    }
}
