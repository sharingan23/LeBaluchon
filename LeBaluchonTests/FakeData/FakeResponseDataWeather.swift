//
//  FakeResponseDataWeather.swift
//  LeBaluchonTests
//
//  Created by Vigneswaranathan Sugeethkumar on 04/03/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import Foundation

class FakeResponseDataWeather {
    // MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseDataWeather.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    class WeatherError: Error {}
    static let error = WeatherError()
}
