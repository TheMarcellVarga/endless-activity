import SwiftUI

@MainActor
@Observable
final class SavedViewModel {
    private let catalogLoader: ActivityCatalogLoader
    private let persistenceStore: ActivityPersistenceStore
    private(set) var savedActivities: [Activity] = []
    private(set) var errorMessage: String?

    init(
        catalogLoader: ActivityCatalogLoader = ActivityCatalogLoader(),
        persistenceStore: ActivityPersistenceStore = ActivityPersistenceStore()
    ) {
        self.catalogLoader = catalogLoader
        self.persistenceStore = persistenceStore
    }

    func load(bundle: Bundle = .main) {
        do {
            let catalog = try catalogLoader.load(bundle: bundle)
            let state = try persistenceStore.load()
            savedActivities = catalog.filter { state.savedIDs.contains($0.id) }
            errorMessage = nil
        } catch {
            errorMessage = "Saved activities could not be loaded."
        }
    }

    func remove(_ activity: Activity) {
        do {
            try persistenceStore.update { $0.savedIDs.remove(activity.id) }
            savedActivities.removeAll { $0.id == activity.id }
        } catch {
            errorMessage = "That activity could not be removed."
        }
    }
}

struct SavedView: View {
    @State private var model = SavedViewModel()
    @State private var selectedActivity: Activity?

    var body: some View {
        NavigationStack {
            Group {
                if let errorMessage = model.errorMessage {
                    ContentUnavailableView("Saved unavailable", systemImage: "exclamationmark.triangle", description: Text(errorMessage))
                } else if model.savedActivities.isEmpty {
                    ContentUnavailableView {
                        Label("Nothing saved yet", systemImage: "bookmark")
                    } description: {
                        Text("Swipe an idea right in Discover and it will wait here.")
                    }
                    .accessibilityIdentifier("emptySaved")
                } else {
                    List {
                        ForEach(model.savedActivities) { activity in
                            Button { selectedActivity = activity } label: {
                                SavedActivityRow(activity: activity)
                            }
                            .buttonStyle(.plain)
                            .accessibilityHint("Opens activity details")
                            .swipeActions {
                                Button(role: .destructive) { model.remove(activity) } label: {
                                    Label("Remove", systemImage: "bookmark.slash")
                                }
                            }
                        }
                        .onDelete { offsets in
                            offsets.map { model.savedActivities[$0] }.forEach(model.remove)
                        }
                    }
                    .listStyle(.plain)
                    .accessibilityIdentifier("savedList")
                }
            }
            .background(AppTheme.paper)
            .navigationTitle("Saved")
            .onAppear { model.load() }
            .sheet(item: $selectedActivity) { activity in
                ActivityDetailView(activity: activity, isSaved: true) {
                    model.remove(activity)
                }
            }
        }
    }
}

private struct SavedActivityRow: View {
    let activity: Activity

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: activity.category.systemImage)
                .font(.title3.weight(.semibold))
                .foregroundStyle(activity.category.tint)
                .frame(width: 42, height: 42)
                .background(activity.category.tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 6) {
                Text(activity.title).font(.headline).foregroundStyle(AppTheme.ink)
                Text(activity.summary).font(.subheadline).foregroundStyle(.secondary).lineLimit(2)
                Text("\(activity.durationText)  ·  \(activity.costLevel.displayName)  ·  \(activity.energyLevel.displayName)")
                    .font(.caption.weight(.medium)).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(activity.accessibilitySummary)
    }
}

#Preview { SavedView() }
