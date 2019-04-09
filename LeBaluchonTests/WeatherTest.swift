//
//  weatherTest.swift
//  LeBaluchonTests
//
//  Created by Vigneswaranathan Sugeethkumar on 09/04/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class WeatherTest: XCTestCase {
    //Weather Test
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherManager(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(fromCity: "Paris") { (weather, error) in
            // Then
            XCTAssertNil(weather)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherManager(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(fromCity: "Paris") { (weather, error) in
            // Then
            XCTAssertNil(weather)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherManager (weatherSession: URLSessionFake(data: FakeResponseDataWeather.weatherCorrectData, response: FakeResponseDataWeather.responseKO, error: nil))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(fromCity: "Paris") { (weather, error) in
            // Then
            
            XCTAssertNil(error)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherManager(weatherSession: URLSessionFake(data: FakeResponseDataWeather.weatherIncorrectData, response: FakeResponseDataWeather.responseOK, error: nil))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(fromCity:"Paris" ){ (weather, error) in
            // Then
            XCTAssertNotNil(error)
            let lon = 145.77
            
            XCTAssertNotEqual(lon, weather?.coordinate?.longitude)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfcorrectData() {
        // Given
        let weatherService = WeatherManager(weatherSession: URLSessionFake(data: FakeResponseDataWeather.weatherCorrectData, response: FakeResponseDataWeather.responseOK, error: nil))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(fromCity:"Paris" ){ (weather, error) in
            // Then
            XCTAssertNil(error)
            let lon = 145.77
            
            XCTAssertEqual(lon, weather!.coordinate?.longitude)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
}
