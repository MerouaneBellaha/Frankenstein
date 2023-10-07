//
//  FrankensteinUITests.swift
//  FrankensteinUITests
//
//  Created by Merouane Bellaha on 06/10/2023.
//

import XCTest

final class FrankensteinUITests: XCTestCase {
    func test_addTask() throws {
        let app = launchApp()

        let textField = app.textFields["task name textField"]

        textField.tap()
        textField.typeText("task")

        app.buttons["add task button"].tap()

        XCTAssertTrue(app.staticTexts["task"].exists)
    }

    func test_deleteTask() throws {
        let app = launchApp()

        let textField = app.textFields["task name textField"]

        textField.tap()
        textField.typeText("task")

        app.buttons["add task button"].tap()

        XCTAssertTrue(app.staticTexts["task"].exists)

        app.staticTexts["task"].swipeLeft()

        app.buttons["Delete"].tap()

        XCTAssertFalse(app.staticTexts["task"].exists)
    }

    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        return app
    }
}
