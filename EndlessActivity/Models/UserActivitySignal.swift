import Foundation

enum UserActivityAction: String, Codable, Sendable {
    case saved, skipped, completed
}

struct UserActivitySignal: Codable, Equatable, Identifiable, Sendable {
    let activityId: String
    let action: UserActivityAction
    let timestamp: Date

    var id: String {
        "\(activityId)-\(action.rawValue)-\(timestamp.timeIntervalSince1970)"
    }
}
