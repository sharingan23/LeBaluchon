//
//  TranslateTest.swift
//  LeBaluchonTests
//
//  Created by Vigneswaranathan Sugeethkumar on 09/04/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class TranslateTest: XCTestCase {
    // Translate Test
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        let translateService = Translate(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseDataTranslate.error))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translateService.getText(withText: "Je suis un génie incompris",targetLanguage: "en",sourceLanguage: "fr") { (translate, error) in
            // Then
            XCTAssertNil(translate)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let tanslateService = Translate(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        tanslateService.getText(withText: "Je suis un génie incompris",targetLanguage: "en",sourceLanguage: "fr") { (translate, error) in
            // Then
            XCTAssertNil(translate)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let tanslateService = Translate(translateSession: URLSessionFake(data: FakeResponseDataTranslate.translateCorrectData, response: FakeResponseDataTranslate.responseKO, error: nil))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        tanslateService.getText(withText: "Je suis un génie incompris",targetLanguage: "en",sourceLanguage: "fr") { (translate, error) in
            // Then
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let tanslateService = Translate(translateSession: URLSessionFake(data: FakeResponseDataTranslate.translateIncorrectData, response: FakeResponseDataTranslate.responseOK, error: nil))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        tanslateService.getText(withText: "Je suis un génie incompris",targetLanguage: "en",sourceLanguage: "fr") { (translate, error) in
            // Then
            XCTAssertNotNil(error)
            let tranlatedText = "I am a misunderstood genius"
            
            XCTAssertNotEqual(tranlatedText, translate?.data?.translations[0]?.translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfcorrectData() {
        // Given
        let tanslateService = Translate(translateSession: URLSessionFake(data: FakeResponseDataTranslate.translateCorrectData, response: FakeResponseDataTranslate.responseOK, error: nil))
        
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        tanslateService.getText(withText: "Je suis un génie incompris",targetLanguage: "en",sourceLanguage: "fr") { (translate, error) in
            // Then
            XCTAssertNil(error)
            let tranlatedText = "I am a misunderstood genius"
            
            XCTAssertEqual(tranlatedText, translate?.data?.translations[0]?.translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
} 
