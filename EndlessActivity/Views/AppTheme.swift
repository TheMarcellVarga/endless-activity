import SwiftUI

enum AppTheme {
    static let ink = Color(red: 15 / 255, green: 17 / 255, blue: 19 / 255)
    static let paper = Color(red: 245 / 255, green: 246 / 255, blue: 247 / 255)
    static let actionCoral = Color(red: 1.0, green: 90 / 255, blue: 79 / 255)
    static let leaf = Color(red: 52 / 255, green: 199 / 255, blue: 89 / 255)
    static let sky = Color(red: 74 / 255, green: 163 / 255, blue: 1.0)
    static let sun = Color(red: 1.0, green: 196 / 255, blue: 0)
}

extension Activity {
    var durationText: String { durationMinutes < 60 ? "\(durationMinutes) min" : "\(durationMinutes / 60) hr" }
    var accessibilitySummary: String {
        "\(title). \(summary) \(durationText), \(costLevel.displayName) cost, \(energyLevel.displayName) energy, \(setting.displayName)."
    }
}

extension ActivityCategory {
    var displayName: String { rawValue.capitalized }
    var systemImage: String {
        switch self {
        case .creative: "paintpalette"
        case .movement: "figure.walk"
        case .food: "fork.knife"
        case .home: "house"
        case .learning: "book"
        case .social: "person.2"
        case .outdoors: "leaf"
        case .reset: "sparkles"
        case .entertainment: "play.rectangle"
        }
    }
    var tint: Color {
        switch self {
        case .movement, .outdoors: AppTheme.leaf
        case .learning, .entertainment: AppTheme.sky
        case .food, .home: AppTheme.sun
        default: AppTheme.actionCoral
        }
    }
}

extension CostLevel { var displayName: String { rawValue.capitalized } }
extension EnergyLevel { var displayName: String { rawValue.capitalized } }
extension SocialMode { var displayName: String { self == .any ? "Any" : rawValue.capitalized } }
extension ActivitySetting {
    var displayName: String { rawValue.capitalized }
    var systemImage: String { self == .indoor ? "house" : self == .outdoor ? "sun.max" : "arrow.triangle.branch" }
}
