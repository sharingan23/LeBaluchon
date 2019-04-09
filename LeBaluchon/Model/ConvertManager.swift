//
//  ConvertManager.swift
//  LeBaluchon
//
//  Created by Vigneswaranathan Sugeethkumar on 04/02/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import Foundation

// Convert Json to struct

struct Convert: Codable {
    var rates: Rates?
    
    enum CodingKeys: String, CodingKey {
        case rates = "rates"
    }
}

extension Convert {
    struct Rates: Codable {
        var usd: Double
        var eur: Double
        
        enum CodingKeys: String, CodingKey {
            case usd = "USD"
            case eur = "EUR"
        }
    }
}

    
class ConvertManager {
    
    private var convertSession = URLSession(configuration: .default)
    // Initialization URLSession
    init(convertSession: URLSession) {
        self.convertSession = convertSession
    }
    
    //function that retrieive JSON from server and convert the data into our struct
    func getConvert(completionHandler: @escaping (Convert?, Error?) -> Void) {
        let request = createConvertRequest()
        
        let task = convertSession.dataTask(with: request) { (data, response, error) in
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
                    // try to decode the JSON
                    let responseJSON = try JSONDecoder().decode(Convert.self, from: data)
                    completionHandler(responseJSON, nil)
                } catch {
                    completionHandler( nil, error)
                }
             }
        }
        task.resume()
    } 
    
    // Request
    func createConvertRequest() -> URLRequest {
        let request = URLRequest(url: URL(string: "http://data.fixer.io/api/latest?access_key=badc741d8000161128b6bf6ae8e9053f")!)
        
        return request
    }
}

