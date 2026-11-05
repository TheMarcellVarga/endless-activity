import Foundation

enum ActivityCategory: String, Codable, CaseIterable, Sendable {
    case creative, movement, food, home, learning, social, outdoors, reset, entertainment
}

enum CostLevel: String, Codable, CaseIterable, Sendable {
    case free, low, medium, high
}

enum EnergyLevel: String, Codable, CaseIterable, Sendable {
    case low, medium, high
}

enum ActivitySetting: String, Codable, CaseIterable, Sendable {
    case indoor, outdoor, either
}

enum SocialMode: String, Codable, CaseIterable, Sendable {
    case solo, friend, date, group, any
}

struct Activity: Codable, Equatable, Identifiable, Sendable {
    let id: String
    let title: String
    let summary: String
    let category: ActivityCategory
    let durationMinutes: Int
    let costLevel: CostLevel
    let energyLevel: EnergyLevel
    let setting: ActivitySetting
    let socialMode: SocialMode
    let tags: [String]
    let materials: [String]
    let steps: [String]
    let safetyNote: String?
}
