import Foundation

enum ActivityCatalogError: Error, Equatable, LocalizedError {
    case resourceNotFound(String)
    case decodingFailed(String)
    case duplicateID(String)
    case duplicateTitle(String)
    case invalidRecord(id: String, reason: String)

    var errorDescription: String? {
        switch self {
        case let .resourceNotFound(name): "Catalog resource not found: \(name).json"
        case let .decodingFailed(message): "Catalog decoding failed: \(message)"
        case let .duplicateID(id): "Duplicate activity ID: \(id)"
        case let .duplicateTitle(title): "Duplicate activity title: \(title)"
        case let .invalidRecord(id, reason): "Invalid activity \(id): \(reason)"
        }
    }
}

struct ActivityCatalogLoader {
    private let decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func load(resource: String = "activities", bundle: Bundle = .main) throws -> [Activity] {
        guard let url = bundle.url(forResource: resource, withExtension: "json") else {
            throw ActivityCatalogError.resourceNotFound(resource)
        }
        return try load(data: Data(contentsOf: url))
    }

    func load(data: Data) throws -> [Activity] {
        let activities: [Activity]
        do {
            activities = try decoder.decode([Activity].self, from: data)
        } catch {
            throw ActivityCatalogError.decodingFailed(error.localizedDescription)
        }
        try validate(activities)
        return activities
    }

    func validate(_ activities: [Activity]) throws {
        var ids = Set<String>()
        var titles = Set<String>()

        for activity in activities {
            guard ids.insert(activity.id).inserted else {
                throw ActivityCatalogError.duplicateID(activity.id)
            }
            guard titles.insert(activity.title.lowercased()).inserted else {
                throw ActivityCatalogError.duplicateTitle(activity.title)
            }
            guard activity.id.range(of: #"^[a-z]+-[a-z0-9-]+-[0-9]{3}$"#, options: .regularExpression) != nil else {
                throw ActivityCatalogError.invalidRecord(id: activity.id, reason: "ID must use the locked kebab-case format")
            }
            guard !activity.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  activity.title.count < 60 else {
                throw ActivityCatalogError.invalidRecord(id: activity.id, reason: "title must contain 1 to 59 characters")
            }
            guard !activity.summary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  activity.summary.count < 160 else {
                throw ActivityCatalogError.invalidRecord(id: activity.id, reason: "summary must contain 1 to 159 characters")
            }
            guard activity.durationMinutes > 0 else {
                throw ActivityCatalogError.invalidRecord(id: activity.id, reason: "duration must be positive")
            }
            guard (2...6).contains(activity.tags.count), Set(activity.tags).count == activity.tags.count,
                  activity.tags.allSatisfy({ $0.range(of: #"^[a-z0-9]+(?:-[a-z0-9]+)*$"#, options: .regularExpression) != nil }) else {
                throw ActivityCatalogError.invalidRecord(id: activity.id, reason: "tags must be 2 to 6 unique lowercase kebab-case values")
            }
            guard (2...5).contains(activity.steps.count),
                  activity.steps.allSatisfy({ !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) else {
                throw ActivityCatalogError.invalidRecord(id: activity.id, reason: "steps must contain 2 to 5 concrete entries")
            }
        }
    }
}
