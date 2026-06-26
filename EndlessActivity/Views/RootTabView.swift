import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "safari")
                }

            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }

            PreferencesView()
                .tabItem {
                    Label("Preferences", systemImage: "slider.horizontal.3")
                }
        }
        .tint(AppTheme.actionCoral)
    }
}

#Preview {
    RootTabView()
}
