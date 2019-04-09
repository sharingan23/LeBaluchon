//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Vigneswaranathan Sugeethkumar on 07/01/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    //Outlet of Temperature
    @IBOutlet weak var NewYorkTemp: UILabel!
    @IBOutlet weak var ParisTemp: UILabel!
    //Outlet of Condition
    @IBOutlet weak var ConditionNewYork: UILabel!
    @IBOutlet weak var ConditionParis: UILabel!
    //Outlet of Icon
    @IBOutlet weak var IconNewYork: UIImageView!
    @IBOutlet weak var IconParis: UIImageView!
    //Outlet of background
    @IBOutlet var backGroundView: UIView!
    
    //Gardient layer variable
    let gradientLayer = CAGradientLayer()
    
    //Instance of weather
    var weather = WeatherManager(weatherSession: URLSession(configuration: .default))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set gradient layer color
        setBackgroundColor()
        
        //add background gradient layer
        backGroundView.layer.addSublayer(gradientLayer)
        
        //NewYor Weather
        currentWeather(city: "New+York",cityLabel: NewYorkTemp, cityCondition: ConditionNewYork, iconLabel: IconNewYork)
        
        //Paris Weather
        currentWeather(city: "Paris", cityLabel: ParisTemp, cityCondition: ConditionParis, iconLabel: IconParis)
    }
    
    //func give current  weather
    func currentWeather(city: String,cityLabel: UILabel,cityCondition: UILabel,iconLabel: UIImageView){
        var celsiusTemp = 0.0
        var condition = ""
        weather.getWeather(fromCity: city) { (weatherInfo, error) in
            //Unwrap WeatherInfo
            if let weatherInfo = weatherInfo {
                //temp to degrees
                celsiusTemp = weatherInfo.main!.temp - 273.15
                //condition
                condition = weatherInfo.weather[0]!.main
                //temp in view
                cityLabel.text = "\(Int(celsiusTemp))°"
                //font size
                cityLabel.font = UIFont.systemFont(ofSize: 30)
                //condition in view
                cityCondition.text = condition
                //set icon weather
                self.iconWeather(condition: condition,iconLabel: iconLabel)
            }
        }
    }
    
    // func that give icon image compare to weather condition
    
    func iconWeather(condition: String,iconLabel: UIImageView){
        
        if condition.contains("Clouds") || condition.contains("Mist") || condition.contains("Drizzle") {
            iconLabel.image = UIImage(named: "cloud")
        }
        
        if condition.contains("Clear") || condition.contains("Sun") {
            iconLabel.image = UIImage(named: "sun")
        }
        
        if condition.contains("Rains") || condition.contains("Rain") {
            iconLabel.image = UIImage(named: "rain")
        }

    }
    
    //func that set Back ground color into blue if daytime or to grey if it is night
    func setBackgroundColor() {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour < 20 {
        setBlueBackground()
            
        } else if hour > 20 && hour < 6 {
            setGreyBackground()
            }
    }
    
    //set gradientLayer to blue color
    func setBlueBackground(){
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue:1.0,alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue:184.0,alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    //set gradientLayer to grey color
    func setGreyBackground(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue:151.0,alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue:72.0,alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
}
