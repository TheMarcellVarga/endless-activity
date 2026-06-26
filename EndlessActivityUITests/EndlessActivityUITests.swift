import XCTest

final class EndlessActivityUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchShowsDiscoverTab() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.tabBars.buttons["Discover"].waitForExistence(timeout: 5))
    }
}
