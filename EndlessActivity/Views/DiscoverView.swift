import SwiftUI

struct DiscoverView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Endless Activity")
                            .font(.largeTitle.weight(.bold))
                            .foregroundStyle(AppTheme.ink)

                        Text("Discover will open straight into the activity deck.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }

                    PlaceholderPanel(title: "Discover placeholder", systemImage: "rectangle.stack") {
                        Text("Phase 3 adds the bundled catalog, ranking, and local state. Phase 4 replaces this placeholder with swipeable activity cards.")
                    }

                    VStack(spacing: 12) {
                        Button {
                        } label: {
                            Label("Save action placeholder", systemImage: "bookmark")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(AppTheme.actionCoral)
                        .disabled(true)

                        Button {
                        } label: {
                            Label("Skip action placeholder", systemImage: "xmark")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .disabled(true)
                    }
                }
                .padding(20)
            }
            .background(AppTheme.paper)
            .navigationTitle("Discover")
        }
    }
}

#Preview {
    DiscoverView()
}
