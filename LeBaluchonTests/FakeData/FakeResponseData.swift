//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by Vigneswaranathan Sugeethkumar on 12/02/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var convertCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Convert", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let convertIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    class ConvertError: Error {}
    static let error = ConvertError()
}
