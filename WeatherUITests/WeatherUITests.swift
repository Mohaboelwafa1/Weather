//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Mohammed hassan on 8/6/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import XCTest

class WeatherUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }

    func testClickToDetailsView() {
        let app = XCUIApplication()
        app.activate()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Amsterdam"]/*[[".cells.staticTexts[\"Amsterdam\"]",".staticTexts[\"Amsterdam\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Weather.CityDetailsView"].buttons["Back"].tap()
    }
}
