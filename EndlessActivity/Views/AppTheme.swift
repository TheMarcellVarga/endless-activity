import SwiftUI

enum AppTheme {
    static let ink = Color(uiColor: .label)
    static let paper = Color(uiColor: .systemGroupedBackground)
    static let raisedSurface = Color(uiColor: .secondarySystemGroupedBackground)
    static let actionCoral = Color(red: 1.0, green: 90 / 255, blue: 79 / 255)
    static let leaf = Color(red: 52 / 255, green: 199 / 255, blue: 89 / 255)
    static let sky = Color(red: 74 / 255, green: 163 / 255, blue: 1.0)
    static let sun = Color(red: 1.0, green: 196 / 255, blue: 0)

    static let cardCornerRadius: CGFloat = 20
    static let insetCornerRadius: CGFloat = 12
    static let screenPadding: CGFloat = 20
}

struct PlaceholderPanel<Content: View>: View {
    let title: String
    let systemImage: String
    let content: Content

    init(title: String, systemImage: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.systemImage = systemImage
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: systemImage)
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(AppTheme.actionCoral)
                .frame(width: 56, height: 56)
                .background(
                    AppTheme.actionCoral.opacity(0.12),
                    in: RoundedRectangle(cornerRadius: AppTheme.insetCornerRadius, style: .continuous)
                )

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(AppTheme.ink)

                content
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            AppTheme.raisedSurface,
            in: RoundedRectangle(cornerRadius: AppTheme.cardCornerRadius, style: .continuous)
        )
        .shadow(color: AppTheme.ink.opacity(0.08), radius: 18, x: 0, y: 10)
        .accessibilityElement(children: .combine)
    }
}

struct ActivityCategoryLabel: View {
    let category: ActivityCategory

    var body: some View {
        Label(category.displayName, systemImage: category.systemImage)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(category.tint)
    }
}

struct ActivityMetadataView: View {
    let activity: Activity
    var font: Font = .subheadline

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 16) { labels }
            VStack(alignment: .leading, spacing: 8) { labels }
        }
        .font(font.weight(.medium))
        .foregroundStyle(.secondary)
    }

    @ViewBuilder
    private var labels: some View {
        Label(activity.durationText, systemImage: "clock")
        Label(activity.costLevel.displayName, systemImage: "banknote")
        Label(activity.energyLevel.displayName, systemImage: "bolt")
    }
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
