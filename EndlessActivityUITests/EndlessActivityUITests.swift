import XCTest

final class EndlessActivityUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchShowsDiscoverTab() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.tabBars.buttons["Discover"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.otherElements["activityCard"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Save"].exists)
        XCTAssertTrue(app.buttons["Skip"].exists)
    }

    func testTapCardOpensDetails() throws {
        let app = XCUIApplication()
        app.launch()

        let card = app.otherElements["activityCard"]
        XCTAssertTrue(card.waitForExistence(timeout: 5))
        card.tap()

        XCTAssertTrue(app.navigationBars["Activity details"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Close"].exists)
    }
}
