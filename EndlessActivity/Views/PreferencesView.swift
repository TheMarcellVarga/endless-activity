import SwiftUI

@MainActor
@Observable
final class PreferencesViewModel {
    private let persistenceStore: ActivityPersistenceStore
    private(set) var state = PersistedActivityState()
    private(set) var errorMessage: String?

    init(persistenceStore: ActivityPersistenceStore = ActivityPersistenceStore()) {
        self.persistenceStore = persistenceStore
    }

    func load() {
        do { state = try persistenceStore.load(); errorMessage = nil }
        catch { errorMessage = "Preferences could not be loaded." }
    }

    func updatePreferences(_ transform: (inout ActivityPreferences) -> Void) {
        var updated = state
        transform(&updated.preferences)
        do { try persistenceStore.save(updated); state = updated; errorMessage = nil }
        catch { errorMessage = "That preference could not be saved." }
    }

    func resetFilters() { updatePreferences { $0 = .defaults } }

    func resetHistory() {
        var updated = state
        updated.savedIDs.removeAll()
        updated.skippedIDs.removeAll()
        updated.completedIDs.removeAll()
        do { try persistenceStore.save(updated); state = updated; errorMessage = nil }
        catch { errorMessage = "Your activity history could not be reset." }
    }
}

struct PreferencesView: View {
    @State private var model = PreferencesViewModel()
    @State private var showsResetHistoryConfirmation = false

    var body: some View {
        NavigationStack {
            Form {
                if let errorMessage = model.errorMessage {
                    Section { Label(errorMessage, systemImage: "exclamationmark.triangle").foregroundStyle(.red) }
                }

                Section("Time") {
                    Picker("Maximum duration", selection: durationBinding) {
                        Text("Any length").tag(Int?.none)
                        Text("15 minutes").tag(Int?.some(15))
                        Text("30 minutes").tag(Int?.some(30))
                        Text("60 minutes").tag(Int?.some(60))
                    }
                    .accessibilityIdentifier("durationFilter")
                }

                MultiSelectSection(title: "Cost", values: CostLevel.allCases, selection: costBinding) { $0.displayName }
                MultiSelectSection(title: "Energy", values: EnergyLevel.allCases, selection: energyBinding) { $0.displayName }
                MultiSelectSection(title: "Setting", values: [.indoor, .outdoor], selection: settingBinding) { $0.displayName }
                MultiSelectSection(title: "Company", values: [.solo, .friend, .date, .group], selection: socialBinding) { $0.displayName }
                MultiSelectSection(title: "Categories", values: ActivityCategory.allCases, selection: categoryBinding) { $0.displayName }

                Section {
                    Button("Reset filters") { model.resetFilters() }
                        .disabled(!model.state.preferences.hasActiveFilters)
                        .accessibilityIdentifier("resetFilters")
                    Button("Reset activity history", role: .destructive) { showsResetHistoryConfirmation = true }
                        .disabled(model.state.savedIDs.isEmpty && model.state.skippedIDs.isEmpty && model.state.completedIDs.isEmpty)
                        .accessibilityIdentifier("resetHistory")
                } header: {
                    Text("Reset")
                } footer: {
                    Text("Resetting history clears saved, skipped, and completed activities. Your filters stay unchanged.")
                }
            }
            .scrollContentBackground(.hidden)
            .background(AppTheme.paper)
            .navigationTitle("Preferences")
            .navigationBarTitleDisplayMode(.large)
            .onAppear { model.load() }
            .confirmationDialog("Reset all activity history?", isPresented: $showsResetHistoryConfirmation, titleVisibility: .visible) {
                Button("Reset history", role: .destructive) { model.resetHistory() }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This cannot be undone.")
            }
        }
    }

    private var durationBinding: Binding<Int?> { Binding(get: { model.state.preferences.maxDurationMinutes }, set: { value in model.updatePreferences { $0.maxDurationMinutes = value } }) }
    private var costBinding: Binding<Set<CostLevel>> { selectionBinding(\.allowedCostLevels) }
    private var energyBinding: Binding<Set<EnergyLevel>> { selectionBinding(\.allowedEnergyLevels) }
    private var settingBinding: Binding<Set<ActivitySetting>> { selectionBinding(\.allowedSettings) }
    private var socialBinding: Binding<Set<SocialMode>> { selectionBinding(\.allowedSocialModes) }
    private var categoryBinding: Binding<Set<ActivityCategory>> { selectionBinding(\.selectedCategories) }

    private func selectionBinding<Value>(_ keyPath: WritableKeyPath<ActivityPreferences, Set<Value>>) -> Binding<Set<Value>> where Value: Hashable {
        Binding(get: { model.state.preferences[keyPath: keyPath] }, set: { value in model.updatePreferences { $0[keyPath: keyPath] = value } })
    }
}

private struct MultiSelectSection<Value: Hashable & Identifiable>: View where Value.ID == Value {
    let title: String
    let values: [Value]
    @Binding var selection: Set<Value>
    let label: (Value) -> String

    init(title: String, values: [Value], selection: Binding<Set<Value>>, label: @escaping (Value) -> String) {
        self.title = title; self.values = values; self._selection = selection; self.label = label
    }

    var body: some View {
        Section(title) {
            ForEach(values) { value in
                Button {
                    if selection.contains(value) { selection.remove(value) } else { selection.insert(value) }
                } label: {
                    HStack {
                        Text(label(value)).foregroundStyle(.primary)
                        Spacer()
                        if selection.contains(value) { Image(systemName: "checkmark").foregroundStyle(AppTheme.actionCoral) }
                    }
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
                .accessibilityValue(selection.contains(value) ? "Selected" : "Not selected")
                .accessibilityAddTraits(selection.contains(value) ? .isSelected : [])
            }
        }
    }
}

extension ActivityCategory: Identifiable { var id: Self { self } }
extension CostLevel: Identifiable { var id: Self { self } }
extension EnergyLevel: Identifiable { var id: Self { self } }
extension ActivitySetting: Identifiable { var id: Self { self } }
extension SocialMode: Identifiable { var id: Self { self } }

#Preview { PreferencesView() }
