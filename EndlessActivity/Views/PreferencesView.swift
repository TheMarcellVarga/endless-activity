import SwiftUI

struct PreferencesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    PlaceholderPanel(title: "Preferences placeholder", systemImage: "slider.horizontal.3") {
                        Text("Duration, cost, energy, setting, social mode, and category filters will be wired after the catalog and preferences models exist.")
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Upcoming controls")
                            .font(.headline)
                            .foregroundStyle(AppTheme.ink)

                        Label("Duration and cost filters", systemImage: "clock")
                        Label("Energy and setting filters", systemImage: "bolt")
                        Label("Category chips", systemImage: "square.grid.2x2")
                        Label("Reset filters and reset skipped", systemImage: "arrow.counterclockwise")
                    }
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(.white, in: RoundedRectangle(cornerRadius: 8))
                }
                .padding(20)
            }
            .background(AppTheme.paper)
            .navigationTitle("Preferences")
        }
    }
}

#Preview {
    PreferencesView()
}
