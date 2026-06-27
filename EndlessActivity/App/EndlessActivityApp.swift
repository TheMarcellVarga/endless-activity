import SwiftUI

@main
struct EndlessActivityApp: App {
    init() {
        if ProcessInfo.processInfo.arguments.contains("-reset-state") {
            UserDefaults.standard.removeObject(forKey: "endless-activity-state-v1")
        }
    }
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
    }
}
