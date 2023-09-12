//
//  weatherModel.swift
//  WEATHER_APPLICATION
//
//  Created by Pragadeesh S on 11/09/23.
//

import Foundation

class WeatherDataModel {
    
    var temperature : Int?
    var city : String?
    var weatherIconName : String?
    var onlineIconName : String?
    var weatherDescription : String?
    var weatherName : String?
    var messageError : String?
    var Feelslike : Int?
    var WindSpeed : Double?
    var Humdiity : Int?
    var Pressure : Int?
    
    
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...212 :
            return "tstorm1"
            
        case 213...232 :
            return "tstorm3"
            
        case 300...321 :
            return "drizzle"
            
        case 500...531 :
            return "rain"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 781 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        default :
            return "Cloud-Refresh"
        }
        
    }
}
