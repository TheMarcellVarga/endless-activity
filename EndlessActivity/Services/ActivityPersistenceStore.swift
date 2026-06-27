import Foundation

struct PersistedActivityState: Codable, Equatable, Sendable {
    var savedIDs: Set<String> = []
    var skippedIDs: Set<String> = []
    var completedIDs: Set<String> = []
    var preferences: ActivityPreferences = .defaults
}

final class ActivityPersistenceStore {
    private let defaults: UserDefaults
    private let key: String
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(
        defaults: UserDefaults = .standard,
        key: String = "endless-activity-state-v1",
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.defaults = defaults
        self.key = key
        self.encoder = encoder
        self.decoder = decoder
    }

    func load() throws -> PersistedActivityState {
        guard let data = defaults.data(forKey: key) else { return PersistedActivityState() }
        return try decoder.decode(PersistedActivityState.self, from: data)
    }

    func save(_ state: PersistedActivityState) throws {
        defaults.set(try encoder.encode(state), forKey: key)
    }

    func update(_ transform: (inout PersistedActivityState) -> Void) throws {
        var state = try load()
        transform(&state)
        try save(state)
    }

    func resetSkipped() throws {
        try update { $0.skippedIDs.removeAll() }
    }

    func resetFilters() throws {
        try update { $0.preferences = .defaults }
    }
}
