//
//  Translate.swift
//  LeBaluchon
//
//  Created by Vigneswaranathan Sugeethkumar on 07/01/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import Foundation

// Convert Json to struc
struct Translator : Codable {
    var data: Data?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
    
extension Translator {
    struct Data: Codable {
        var translations: [Translations?]
            
        enum CodingKeys: String, CodingKey {
            case translations
        }
    }
    
    struct Translations: Codable {
        var detectedSourceLanguage: String
        var translatedText: String
        
        enum CodingKeys: String, CodingKey {
            case detectedSourceLanguage
            case translatedText
        }
    }
}


class Translate {
    
    private var translateSession = URLSession(configuration: .default)
    
    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }
    
    //function that retrieive JSON from server and convert the data into our struct
    
    func getText(withText text: String,targetLanguage: String,sourceLanguage: String, completionHandler: @escaping (Translator?, Error?) -> Void) {
        
        let request = createTranslateRequest(withText: text, targetLanguage: targetLanguage, sourceLanguage: sourceLanguage)
        
        let task = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler( nil, error)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler( nil, error)
                    return
                }
                
                do {
                    let responseJSON = try JSONDecoder().decode(Translator.self, from: data)
                    return completionHandler(responseJSON, nil)
                } catch {
                    completionHandler( nil, error)
                }
            }
        }
        task.resume()
    }
    
    func createTranslateRequest(withText text: String,targetLanguage: String,sourceLanguage: String) -> URLRequest {
        
        // replacing space into %20 in the given text
        let queryText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = "https://translation.googleapis.com/language/translate/v2/?q=\(queryText!)&target=\(targetLanguage)&\(sourceLanguage)&key=AIzaSyCco-FaOfWreicLWO-D3nT5uQGfYsrsnWM"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        return request
    }
}
