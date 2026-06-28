import XCTest

@MainActor
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

    private func attachScreenshot(named name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
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

    func testSwipeGesturesAdvanceDeckAndSave() throws {
        let app = launchCleanApp()
        let card = app.otherElements["activityCard"]
        XCTAssertTrue(card.waitForExistence(timeout: 5))

        let cardContent = app.otherElements["activityCardContent"]
        XCTAssertTrue(cardContent.waitForExistence(timeout: 3))
        let firstActivity = cardContent.label

        card.swipeLeft()
        XCTAssertTrue(card.waitForExistence(timeout: 3))
        XCTAssertNotEqual(cardContent.label, firstActivity)

        card.swipeRight()
        app.tabBars.buttons["Saved"].tap()

        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3))
        XCTAssertFalse(app.staticTexts["Nothing saved yet"].exists)
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

    func testSavedStateSurvivesRelaunch() throws {
        let app = launchCleanApp()
        XCTAssertTrue(app.buttons["Save"].waitForExistence(timeout: 5))
        app.buttons["Save"].tap()

        app.launchArguments = []
        app.launch()
        app.tabBars.buttons["Saved"].tap()

        XCTAssertTrue(app.cells.firstMatch.waitForExistence(timeout: 5))
        XCTAssertFalse(app.staticTexts["Nothing saved yet"].exists)
    }

    func testCapturePhase6Screenshots() throws {
        let app = launchCleanApp()
        let card = app.otherElements["activityCard"]
        XCTAssertTrue(card.waitForExistence(timeout: 5))
        attachScreenshot(named: "01-discover")

        card.tap()
        XCTAssertTrue(app.navigationBars["Activity details"].waitForExistence(timeout: 3))
        attachScreenshot(named: "02-activity-detail")
        app.buttons["Save for later"].tap()

        app.tabBars.buttons["Saved"].tap()
        XCTAssertTrue(app.cells.firstMatch.waitForExistence(timeout: 3))
        attachScreenshot(named: "03-saved")

        app.tabBars.buttons["Preferences"].tap()
        XCTAssertTrue(app.navigationBars["Preferences"].waitForExistence(timeout: 3))
        attachScreenshot(named: "04-preferences")
    }
}
