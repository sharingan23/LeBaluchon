//
//  FakeResponseDataTranslate.swift
//  LeBaluchonTests
//
//  Created by Vigneswaranathan Sugeethkumar on 25/03/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import Foundation

class FakeResponseDataTranslate {
    // MARK: - Data
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseDataTranslate.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let translateIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    class TranslateError: Error {}
    static let error = TranslateError()
}
