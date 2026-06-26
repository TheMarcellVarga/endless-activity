import SwiftUI

struct SavedView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    PlaceholderPanel(title: "Saved placeholder", systemImage: "bookmark") {
                        Text("Saved activities will appear here after the swipe deck and local persistence are implemented.")
                    }

                    Button {
                    } label: {
                        Label("Back to Discover placeholder", systemImage: "arrow.left")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .disabled(true)
                }
                .padding(20)
            }
            .background(AppTheme.paper)
            .navigationTitle("Saved")
        }
    }
}

#Preview {
    SavedView()
}
