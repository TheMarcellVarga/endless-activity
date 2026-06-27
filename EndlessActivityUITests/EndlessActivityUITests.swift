import XCTest

final class EndlessActivityUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    private func launchCleanApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-reset-state"]
        app.launch()
        return app
    }

    func testLaunchShowsDiscoverTab() throws {
        let app = launchCleanApp()

        XCTAssertTrue(app.tabBars.buttons["Discover"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.otherElements["activityCard"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Save"].exists)
        XCTAssertTrue(app.buttons["Skip"].exists)
    }

    func testTapCardOpensDetails() throws {
        let app = launchCleanApp()

        let card = app.otherElements["activityCard"]
        XCTAssertTrue(card.waitForExistence(timeout: 5))
        card.tap()

        XCTAssertTrue(app.navigationBars["Activity details"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Close"].exists)
    }

    func testSaveAppearsInSavedAndCanBeRemoved() throws {
        let app = launchCleanApp()
        XCTAssertTrue(app.buttons["Save"].waitForExistence(timeout: 5))
        app.buttons["Save"].tap()

        app.tabBars.buttons["Saved"].tap()
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3))
        firstCell.swipeLeft()
        app.buttons["Remove"].tap()
        XCTAssertTrue(app.staticTexts["Nothing saved yet"].waitForExistence(timeout: 3))
    }

    func testPreferencesPersistAndReset() throws {
        let app = launchCleanApp()
        app.tabBars.buttons["Preferences"].tap()
        app.buttons["Maximum duration, Any length"].tap()
        app.buttons["15 minutes"].tap()
        let resetFilters = app.buttons["Reset filters"]
        for _ in 0..<6 where !resetFilters.exists { app.swipeUp() }
        XCTAssertTrue(resetFilters.exists)
        XCTAssertTrue(resetFilters.isEnabled)
        resetFilters.tap()
        XCTAssertFalse(resetFilters.isEnabled)
    }
}
