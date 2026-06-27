import XCTest
@testable import EndlessActivity

final class EndlessActivityTests: XCTestCase {
    private let loader = ActivityCatalogLoader()

    func testBundledCatalogDecodesAndValidates() throws {
        let activities = try loader.load(bundle: Bundle(for: Self.self))

        XCTAssertEqual(activities.count, 50)
        XCTAssertEqual(Set(activities.map(\.id)).count, 50)
        XCTAssertEqual(Set(activities.map(\.title)).count, 50)
        XCTAssertGreaterThanOrEqual(
            activities.filter { $0.costLevel == .free || $0.costLevel == .low }.count,
            35
        )
    }

    func testCatalogRejectsDuplicateIDs() throws {
        let activity = makeActivity(id: "creative-test-item-001")
        let data = try JSONEncoder().encode([activity, activity])

        XCTAssertThrowsError(try loader.load(data: data)) { error in
            XCTAssertEqual(error as? ActivityCatalogError, .duplicateID(activity.id))
        }
    }

    func testCatalogRejectsInvalidRecords() throws {
        let activity = makeActivity(id: "Bad ID")
        let data = try JSONEncoder().encode([activity])

        XCTAssertThrowsError(try loader.load(data: data))
    }

    func testAllFiltersExcludeNonMatchingActivities() {
        let service = ActivityRankingService()
        let matching = makeActivity(
            id: "creative-short-item-001",
            category: .creative,
            duration: 10,
            cost: .free,
            energy: .low,
            setting: .indoor,
            social: .solo
        )
        let excluded = makeActivity(
            id: "movement-long-item-002",
            category: .movement,
            duration: 60,
            cost: .medium,
            energy: .high,
            setting: .outdoor,
            social: .group
        )
        let preferences = ActivityPreferences(
            selectedCategories: [.creative],
            maxDurationMinutes: 15,
            allowedCostLevels: [.free],
            allowedEnergyLevels: [.low],
            allowedSettings: [.indoor],
            allowedSocialModes: [.solo]
        )

        XCTAssertEqual(
            service.rankedActivities(
                catalog: [excluded, matching],
                preferences: preferences,
                savedIDs: [],
                skippedIDs: []
            ).map(\.id),
            [matching.id]
        )
    }

    func testSavedAndSkippedActivitiesAreExcluded() {
        let service = ActivityRankingService()
        let saved = makeActivity(id: "creative-saved-item-001")
        let skipped = makeActivity(id: "creative-skipped-item-002")
        let eligible = makeActivity(id: "creative-eligible-item-003")

        let result = service.rankedActivities(
            catalog: [saved, skipped, eligible],
            preferences: .defaults,
            savedIDs: [saved.id],
            skippedIDs: [skipped.id]
        )

        XCTAssertEqual(result.map(\.id), [eligible.id])
    }

    func testSavedCategoryAndTagsBoostRanking() {
        let service = ActivityRankingService()
        let saved = makeActivity(id: "creative-saved-item-001", tags: ["photo", "calm"])
        let boosted = makeActivity(id: "creative-boosted-item-002", tags: ["photo", "make"])
        let neutral = makeActivity(id: "home-neutral-item-003", category: .home, tags: ["home", "tidy"])

        let result = service.rankedActivities(
            catalog: [neutral, boosted, saved],
            preferences: .defaults,
            savedIDs: [saved.id],
            skippedIDs: [],
            sessionSeed: 42
        )

        XCTAssertEqual(result.first?.id, boosted.id)
    }

    func testStableSessionOrderChangesOnlyWithSeed() {
        let service = ActivityRankingService()
        let catalog = (1...8).map {
            makeActivity(id: String(format: "creative-item-%03d", $0))
        }
        let first = service.rankedActivities(
            catalog: catalog,
            preferences: .defaults,
            savedIDs: [],
            skippedIDs: [],
            sessionSeed: 7
        )
        let repeated = service.rankedActivities(
            catalog: catalog,
            preferences: .defaults,
            savedIDs: [],
            skippedIDs: [],
            sessionSeed: 7
        )
        let different = service.rankedActivities(
            catalog: catalog,
            preferences: .defaults,
            savedIDs: [],
            skippedIDs: [],
            sessionSeed: 8
        )

        XCTAssertEqual(first, repeated)
        XCTAssertNotEqual(first, different)
    }

    func testPersistenceSurvivesStoreRecreationAndResets() throws {
        let suiteName = "EndlessActivityTests-\(UUID().uuidString)"
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let key = "state"
        let firstStore = ActivityPersistenceStore(defaults: defaults, key: key)
        let preferences = ActivityPreferences(
            selectedCategories: [.creative],
            maxDurationMinutes: 30,
            allowedCostLevels: [.free],
            allowedEnergyLevels: [.low],
            allowedSettings: [.indoor],
            allowedSocialModes: [.solo]
        )
        let expected = PersistedActivityState(
            savedIDs: ["creative-saved-item-001"],
            skippedIDs: ["home-skipped-item-002"],
            completedIDs: [],
            preferences: preferences
        )

        try firstStore.save(expected)
        let recreatedStore = ActivityPersistenceStore(defaults: defaults, key: key)
        XCTAssertEqual(try recreatedStore.load(), expected)

        try recreatedStore.resetSkipped()
        XCTAssertTrue(try recreatedStore.load().skippedIDs.isEmpty)
        XCTAssertEqual(try recreatedStore.load().savedIDs, expected.savedIDs)

        try recreatedStore.resetFilters()
        XCTAssertEqual(try recreatedStore.load().preferences, .defaults)
    }

    @MainActor
    func testDiscoverDeckSaveAndSkipPersistWithoutMutatingCatalog() throws {
        let suiteName = "DiscoverViewModelTests-\(UUID().uuidString)"
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let store = ActivityPersistenceStore(defaults: defaults, key: "state")
        let catalog = [
            makeActivity(id: "creative-first-item-001"),
            makeActivity(id: "home-second-item-002", category: .home)
        ]
        let model = DiscoverViewModel(
            persistenceStore: store,
            sessionSeed: 2,
            loadImmediately: false
        )
        model.load(catalog: catalog)

        let savedID = try XCTUnwrap(model.currentActivity?.id)
        model.saveCurrent()
        let skippedID = try XCTUnwrap(model.currentActivity?.id)
        model.skipCurrent()

        XCTAssertEqual(model.catalog, catalog)
        XCTAssertTrue(model.deck.isEmpty)
        XCTAssertEqual(try store.load().savedIDs, [savedID])
        XCTAssertEqual(try store.load().skippedIDs, [skippedID])
    }

    @MainActor
    func testDiscoverResetSkippedRefillsDeckButKeepsSavedExcluded() throws {
        let suiteName = "DiscoverResetTests-\(UUID().uuidString)"
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let store = ActivityPersistenceStore(defaults: defaults, key: "state")
        let saved = makeActivity(id: "creative-saved-item-001")
        let skipped = makeActivity(id: "home-skipped-item-002", category: .home)
        let model = DiscoverViewModel(
            persistenceStore: store,
            sessionSeed: 4,
            loadImmediately: false
        )
        model.load(
            catalog: [saved, skipped],
            state: PersistedActivityState(savedIDs: [saved.id], skippedIDs: [skipped.id])
        )

        XCTAssertTrue(model.deck.isEmpty)
        model.resetSkipped()

        XCTAssertEqual(model.deck.map(\.id), [skipped.id])
        XCTAssertEqual(try store.load().savedIDs, [saved.id])
    }

    @MainActor
    func testSavedViewModelLoadsAndRemovesSavedActivity() throws {
        let suiteName = "SavedViewModelTests-\(UUID().uuidString)"
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let store = ActivityPersistenceStore(defaults: defaults, key: "state")
        let catalog = try loader.load(bundle: Bundle(for: Self.self))
        let saved = try XCTUnwrap(catalog.first)
        try store.save(PersistedActivityState(savedIDs: [saved.id]))
        let model = SavedViewModel(persistenceStore: store)

        model.load(bundle: Bundle(for: Self.self))
        XCTAssertEqual(model.savedActivities.map(\.id), [saved.id])

        model.remove(saved)
        XCTAssertTrue(model.savedActivities.isEmpty)
        XCTAssertTrue(try store.load().savedIDs.isEmpty)
    }

    @MainActor
    func testPreferencesViewModelPersistsFiltersAndResetsHistorySeparately() throws {
        let suiteName = "PreferencesViewModelTests-\(UUID().uuidString)"
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let store = ActivityPersistenceStore(defaults: defaults, key: "state")
        try store.save(PersistedActivityState(savedIDs: ["saved"], skippedIDs: ["skipped"]))
        let model = PreferencesViewModel(persistenceStore: store)

        model.load()
        model.updatePreferences { $0.maxDurationMinutes = 15 }
        XCTAssertEqual(try store.load().preferences.maxDurationMinutes, 15)

        model.resetHistory()
        let afterHistoryReset = try store.load()
        XCTAssertTrue(afterHistoryReset.savedIDs.isEmpty)
        XCTAssertTrue(afterHistoryReset.skippedIDs.isEmpty)
        XCTAssertEqual(afterHistoryReset.preferences.maxDurationMinutes, 15)

        model.resetFilters()
        XCTAssertEqual(try store.load().preferences, .defaults)
    }

    private func makeActivity(
        id: String,
        category: ActivityCategory = .creative,
        duration: Int = 20,
        cost: CostLevel = .free,
        energy: EnergyLevel = .low,
        setting: ActivitySetting = .indoor,
        social: SocialMode = .solo,
        tags: [String] = ["calm", "make"]
    ) -> Activity {
        Activity(
            id: id,
            title: "Test \(id)",
            summary: "A concrete test activity.",
            category: category,
            durationMinutes: duration,
            costLevel: cost,
            energyLevel: energy,
            setting: setting,
            socialMode: social,
            tags: tags,
            materials: [],
            steps: ["Start the activity.", "Finish the activity."],
            prepMinutes: nil,
            season: nil,
            timeOfDay: nil,
            spaceNeeded: nil,
            safetyNote: nil
        )
    }
}
