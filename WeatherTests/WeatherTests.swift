//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Mohammed hassan on 8/6/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testSplashViewModel()
        }
    }

    func testSplashViewModel() {
        let viewModel = SplashViewModel()
        viewModel.getCitiesList(completionHandler: {
            (result, statusCode, errorModel) in
            if statusCode == 200 {
                UserDefaults.standard.set(true, forKey: Keys.launchedBefore.rawValue)
            }
        })
    }

    func testSplashViewControllerFunctionality() {
        let viewController = SplashViewController()
        viewController.fetchWeatherData()
    }

    func testCitiesListViewModel_PrepareCell() {
        let viewModel = CitiesListViewModel()
        _ = viewModel.prepareCellModel()
    }

    func testCitiesListViewModel_GetDataOffline() {
        let viewModel = CitiesListViewModel()
        _ = viewModel.getCitiesListOffline()
        XCTAssertTrue(viewModel.citiesList?.isEmpty ?? true)
    }

    func testCitiesListViewModel_getCitiesList() {
        let viewModel = CitiesListViewModel()
        _ = viewModel.getCitiesList(completionHandler: {
            (result, statusCode, errorModel) in
            if statusCode == 200 {
                UserDefaults.standard.set(true, forKey: Keys.launchedBefore.rawValue)
            }
        })
    }

    func testCityDetailsViewModel_prepareCellModel() {
        let viewModel = CityDetailsViewModel()
        _ = viewModel.prepareCellModel(cityName: "Amsterdam")
    }

    func testCityDetailsViewModel_getCityData() {
        let viewModel = CityDetailsViewModel()
        _ = viewModel.getCityData(cityName: "Amsterdam")
    }

    func testCityDetailsViewModel_getImageName() {
        let viewModel = CityDetailsViewModel()
        _ = viewModel.getImageName(temp: 22)
    }

    func testCityDetailsViewController_fetchData() {
        let viewController = CityDetailsViewController()
        viewController.fetchData()
    }

}
