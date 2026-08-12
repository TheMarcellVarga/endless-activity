import SwiftUI

@MainActor
@Observable
final class DiscoverViewModel {
    enum LoadState: Equatable {
        case loading
        case ready
        case failed(String)
    }

    private let catalogLoader: ActivityCatalogLoader
    private let persistenceStore: ActivityPersistenceStore
    private let rankingService: ActivityRankingService
    private let sessionSeed: UInt64

    private(set) var loadState: LoadState = .loading
    private(set) var catalog: [Activity] = []
    private(set) var deck: [Activity] = []
    private(set) var persistedState = PersistedActivityState()
    var selectedActivity: Activity?

    var currentActivity: Activity? { deck.first }

    init(
        catalogLoader: ActivityCatalogLoader = ActivityCatalogLoader(),
        persistenceStore: ActivityPersistenceStore = ActivityPersistenceStore(),
        rankingService: ActivityRankingService = ActivityRankingService(),
        sessionSeed: UInt64 = UInt64.random(in: .min ... .max),
        loadImmediately: Bool = true
    ) {
        self.catalogLoader = catalogLoader
        self.persistenceStore = persistenceStore
        self.rankingService = rankingService
        self.sessionSeed = sessionSeed
        if loadImmediately { load() }
    }

    func load(bundle: Bundle = .main) {
        do {
            catalog = try catalogLoader.load(bundle: bundle)
            persistedState = try persistenceStore.load()
            rebuildDeck()
            loadState = .ready
        } catch {
            loadState = .failed("Activities could not be loaded. Please relaunch the app.")
        }
    }

    func load(catalog: [Activity], state: PersistedActivityState = PersistedActivityState()) {
        self.catalog = catalog
        persistedState = state
        rebuildDeck()
        loadState = .ready
    }

    func saveCurrent() { currentActivity.map(save) }
    func skipCurrent() { currentActivity.map(skip) }

    func save(_ activity: Activity) {
        persistAction(for: activity) {
            $0.savedIDs.insert(activity.id)
            $0.skippedIDs.remove(activity.id)
        }
    }

    func skip(_ activity: Activity) {
        persistAction(for: activity) {
            $0.skippedIDs.insert(activity.id)
            $0.savedIDs.remove(activity.id)
        }
    }

    func resetSkipped() {
        do {
            persistedState.skippedIDs.removeAll()
            try persistenceStore.save(persistedState)
            rebuildDeck()
        } catch {
            loadState = .failed("Your reset could not be saved. Please try again.")
        }
    }

    func resetFilters() {
        do {
            persistedState.preferences = .defaults
            try persistenceStore.save(persistedState)
            rebuildDeck()
        } catch {
            loadState = .failed("Your filters could not be reset. Please try again.")
        }
    }

    func refresh() {
        guard !catalog.isEmpty else { return }
        do {
            persistedState = try persistenceStore.load()
            rebuildDeck()
            loadState = .ready
        } catch {
            loadState = .failed("Your activities could not be refreshed. Please try again.")
        }
    }

    private func persistAction(
        for activity: Activity,
        update: (inout PersistedActivityState) -> Void
    ) {
        var updatedState = persistedState
        update(&updatedState)
        do {
            try persistenceStore.save(updatedState)
            persistedState = updatedState
            deck.removeAll { $0.id == activity.id }
            if selectedActivity?.id == activity.id { selectedActivity = nil }
        } catch {
            loadState = .failed("That action could not be saved. Please try again.")
        }
    }

    private func rebuildDeck() {
        deck = rankingService.rankedActivities(
            catalog: catalog,
            preferences: persistedState.preferences,
            savedIDs: persistedState.savedIDs,
            skippedIDs: persistedState.skippedIDs,
            sessionSeed: sessionSeed
        )
    }
}

struct DiscoverView: View {
    @State private var model = DiscoverViewModel()
    @State private var dragOffset = CGSize.zero
    @State private var isCommittingSwipe = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let swipeThreshold: CGFloat = 110

    var body: some View {
        NavigationStack {
            Group {
                switch model.loadState {
                case .loading:
                    ProgressView("Loading activities")
                case let .failed(message):
                    ContentUnavailableView(
                        "Activities unavailable",
                        systemImage: "exclamationmark.triangle",
                        description: Text(message)
                    )
                case .ready:
                    discoverContent
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.paper)
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { model.refresh() }
            .sheet(item: $model.selectedActivity) { activity in
                ActivityDetailView(
                    activity: activity,
                    isSaved: model.persistedState.savedIDs.contains(activity.id),
                    onSave: { model.save(activity) }
                )
            }
        }
    }

    @ViewBuilder
    private var discoverContent: some View {
        if let activity = model.currentActivity {
            Group {
                if dynamicTypeSize.isAccessibilitySize {
                    ScrollView { activityContent(activity) }
                } else {
                    activityContent(activity)
                }
            }
        } else {
            ContentUnavailableView {
                Label("You reached the end", systemImage: "rectangle.stack.badge.checkmark")
            } description: {
                Text(model.persistedState.preferences.hasActiveFilters
                     ? "Your current filters do not match any remaining ideas."
                     : "Bring skipped ideas back to keep exploring. Saved activities stay saved.")
            } actions: {
                if model.persistedState.preferences.hasActiveFilters {
                    Button("Relax filters") { model.resetFilters() }
                        .accessibilityIdentifier("relaxFilters")
                }
                Button("Reset skipped ideas") { model.resetSkipped() }
                    .buttonStyle(.borderedProminent)
                    .tint(AppTheme.actionCoral)
            }
            .accessibilityIdentifier("emptyDeck")
        }
    }

    private func activityContent(_ activity: Activity) -> some View {
        VStack(spacing: 16) {
            deckStack(activity)

            Text("Swipe left to skip, right to save")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .accessibilityHidden(true)

            actionButtons
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }

    private func deckStack(_ activity: Activity) -> some View {
        ZStack {
            ForEach(Array(model.deck.prefix(3).enumerated()).reversed(), id: \.element.id) { index, card in
                ActivityCardView(activity: card, dragOffset: index == 0 ? dragOffset : .zero)
                    .scaleEffect(index == 0 ? 1 : 1 - CGFloat(index) * 0.035)
                    .offset(y: index == 0 ? dragOffset.height * 0.16 : CGFloat(index) * 11)
                    .rotationEffect(index == 0 ? .degrees(Double(dragOffset.width / 24)) : .zero)
                    .zIndex(Double(3 - index))
                    .allowsHitTesting(index == 0)
                    .accessibilityHidden(index != 0)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture { model.selectedActivity = activity }
        .gesture(dragGesture)
        .accessibilityElement(children: .ignore)
        .accessibilityIdentifier("activityCard")
        .accessibilityLabel(activity.accessibilitySummary)
        .accessibilityHint("Double tap for details. Use the Save or Skip actions to continue.")
        .accessibilityAction(named: "Save") { commit(.save) }
        .accessibilityAction(named: "Skip") { commit(.skip) }
        .accessibilityAction(named: "Show details") { model.selectedActivity = activity }
    }

    private var actionButtons: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 18) {
                skipButton
                saveButton
            }
            VStack(spacing: 12) {
                saveButton
                skipButton
            }
        }
        .disabled(isCommittingSwipe)
    }

    private var skipButton: some View {
        Button { commit(.skip) } label: {
            Label("Skip", systemImage: "xmark")
                .fixedSize(horizontal: true, vertical: false)
                .frame(maxWidth: .infinity, minHeight: 48)
        }
        .buttonStyle(.bordered)
        .tint(AppTheme.ink)
        .accessibilityHint("Skips this activity and shows the next idea")
    }

    private var saveButton: some View {
        Button { commit(.save) } label: {
            Label("Save", systemImage: "bookmark.fill")
                .fixedSize(horizontal: true, vertical: false)
                .frame(maxWidth: .infinity, minHeight: 48)
        }
        .buttonStyle(.borderedProminent)
        .tint(AppTheme.actionCoral)
        .accessibilityHint("Saves this activity and shows the next idea")
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                guard !isCommittingSwipe else { return }
                dragOffset = value.translation
            }
            .onEnded { value in
                let projected = value.predictedEndTranslation.width
                if max(value.translation.width, projected) > swipeThreshold {
                    commit(.save)
                } else if min(value.translation.width, projected) < -swipeThreshold {
                    commit(.skip)
                } else {
                    withAnimation(reduceMotion ? nil : .spring(response: 0.36, dampingFraction: 0.76)) {
                        dragOffset = .zero
                    }
                }
            }
    }

    private enum SwipeAction { case save, skip }

    private func commit(_ action: SwipeAction) {
        guard !isCommittingSwipe, model.currentActivity != nil else { return }
        isCommittingSwipe = true
        let direction: CGFloat = action == .save ? 1 : -1
        if action == .save { model.saveCurrent() } else { model.skipCurrent() }
        let finish: @MainActor @Sendable () -> Void = {
            dragOffset = .zero
            isCommittingSwipe = false
        }

        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        guard !reduceMotion else { finish(); return }
        withAnimation(.easeIn(duration: 0.2)) {
            dragOffset = CGSize(width: direction * 700, height: 24)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: finish)
    }
}

private struct ActivityCardView: View {
    let activity: Activity
    let dragOffset: CGSize
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private var actionProgress: CGFloat { min(abs(dragOffset.width) / 110, 1) }

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack {
                Label(activity.category.displayName, systemImage: activity.category.systemImage)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(activity.category.tint)
                Spacer()
                Image(systemName: "arrow.up.right")
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)
            }

            Spacer(minLength: 4)

            VStack(alignment: .leading, spacing: 12) {
                Text(activity.title)
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .foregroundStyle(AppTheme.ink)
                    .fixedSize(horizontal: false, vertical: true)
                Text(activity.summary)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 4)

            ViewThatFits(in: .horizontal) {
                HStack(spacing: 8) { metadata }
                VStack(alignment: .leading, spacing: 8) { metadata }
            }

            Label(activity.setting.displayName, systemImage: activity.setting.systemImage)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .frame(
            maxWidth: .infinity,
            minHeight: dynamicTypeSize.isAccessibilitySize ? 620 : 390,
            maxHeight: dynamicTypeSize.isAccessibilitySize ? nil : 500,
            alignment: .leading
        )
        .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(alignment: dragOffset.width >= 0 ? .topLeading : .topTrailing) {
            Label(dragOffset.width >= 0 ? "Save" : "Skip", systemImage: dragOffset.width >= 0 ? "bookmark.fill" : "xmark")
                .font(.headline)
                .foregroundStyle(dragOffset.width >= 0 ? AppTheme.actionCoral : AppTheme.ink)
                .padding(16)
                .opacity(actionProgress)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(AppTheme.ink.opacity(0.08), lineWidth: 1)
        }
        .shadow(color: AppTheme.ink.opacity(0.12), radius: 24, x: 0, y: 14)
        .accessibilityElement(children: .ignore)
        .accessibilityIdentifier("activityCardContent")
        .accessibilityLabel(activity.accessibilitySummary)
        .accessibilityHint("Double tap for details. Use the Save or Skip actions to continue.")
    }

    @ViewBuilder
    private var metadata: some View {
        MetadataLabel(text: activity.durationText, systemImage: "clock")
        MetadataLabel(text: activity.costLevel.displayName, systemImage: "banknote")
        MetadataLabel(text: activity.energyLevel.displayName, systemImage: "bolt")
    }
}

private struct MetadataLabel: View {
    let text: String
    let systemImage: String

    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.caption.weight(.semibold))
            .lineLimit(1)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(AppTheme.paper, in: Capsule())
    }
}

struct ActivityDetailView: View {
    let activity: Activity
    let isSaved: Bool
    let onSave: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 10) {
                        Label(activity.category.displayName, systemImage: activity.category.systemImage)
                            .foregroundStyle(activity.category.tint)
                        Text(activity.title)
                            .font(.largeTitle.bold())
                        Text(activity.summary)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    HStack(spacing: 8) {
                        MetadataLabel(text: activity.durationText, systemImage: "clock")
                        MetadataLabel(text: activity.costLevel.displayName, systemImage: "banknote")
                        MetadataLabel(text: activity.energyLevel.displayName, systemImage: "bolt")
                    }

                    if !activity.materials.isEmpty {
                        DetailSection(title: "What you need", items: activity.materials)
                    }
                    DetailSection(title: "Try it", items: activity.steps, numbered: true)

                    if let safetyNote = activity.safetyNote {
                        Label(safetyNote, systemImage: "shield.checkered")
                            .font(.subheadline)
                            .padding(16)
                            .background(AppTheme.sun.opacity(0.16), in: RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(20)
            }
            .background(AppTheme.paper)
            .navigationTitle("Activity details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    onSave()
                    dismiss()
                } label: {
                    Label(isSaved ? "Remove from saved" : "Save for later", systemImage: isSaved ? "bookmark.slash" : "bookmark.fill")
                        .frame(maxWidth: .infinity, minHeight: 48)
                }
                .buttonStyle(.borderedProminent)
                .tint(AppTheme.actionCoral)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
            }
        }
    }
}

private struct DetailSection: View {
    let title: String
    let items: [String]
    var numbered = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.title2.bold())
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                HStack(alignment: .top, spacing: 12) {
                    Text(numbered ? "\(index + 1)" : "•")
                        .font(.subheadline.bold())
                        .foregroundStyle(AppTheme.actionCoral)
                        .frame(width: 22)
                    Text(item).frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview { DiscoverView() }
