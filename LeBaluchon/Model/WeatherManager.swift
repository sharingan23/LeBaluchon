//
//  WeatherInfo.swift
//  LeBaluchon
//
//  Created by Vigneswaranathan Sugeethkumar on 14/01/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import Foundation

// Convert Json to Struct
struct WeatherInfo: Codable {
    var coordinate: Coordinate?
    var main: Main?
    var weather: [Weather?]
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case main
        case weather
    }
}

extension WeatherInfo {
    struct Coordinate: Codable {
        var longitude: Double
        var latitude: Double
    
        enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }
    
    struct Main: Codable {
    var temp: Double
        
        enum CodingKeys: String, CodingKey{
        case temp
        }
    }
    
   struct Weather: Codable {
        var main : String
        
        enum CodingKeys: String, CodingKey {
            case main
        }
    }
}

class WeatherManager {
    private var weatherSession = URLSession(configuration: .default)
    
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }

    //function that retrieive JSON from server and convert the data into our struct
    
    func getWeather(fromCity city: String, completionHandler: @escaping (WeatherInfo?, Error?) -> Void) {
        let request = createWeatherRequest(withCity: city)
        
        let task = weatherSession.dataTask(with: request) { (data, response, error) in
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
                    let responseJSON = try JSONDecoder().decode(WeatherInfo.self, from: data)
                    completionHandler(responseJSON, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
    // request
    func createWeatherRequest(withCity city: String) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=624289a4d075a721cb61cb2a7a28de30")!)
        request.httpMethod = "GET"
        return request
    }
}

