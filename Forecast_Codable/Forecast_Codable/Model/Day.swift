//
//  Day.swift
//  Forecast_Codable
//
//  Created by Esther on 10/10/22.
//

import Foundation
// Forecast by Day
struct TopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case days = "data"
    }
    
    let cityName: String
    let days: [Day]
    
} // End of TopLevelDictionary Struct

struct Day: Decodable {
    private enum CodingKeys: String, CodingKey {
        case temp
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case validDate = "valid_date"
        case weather
    }
    
    let temp: Double
    let highTemp: Double
    let lowTemp: Double
    let validDate: String
    let weather: Weather
    
} // End of Day Struct

struct Weather: Decodable {
    private enum CodingKeys: String, CodingKey {
        case description
        case iconString = "icon"
    }
    
    let description: String
    let iconString: String
    
} // End of Weather Struct


// API data example:
//{
//    "city_name": "Raleigh",
//    "country_code": "US",
//    "data": [
//        {
//            "app_max_temp": 20.2,
//            "app_min_temp": 9.9,
//            "clouds": 26,
//            "clouds_hi": 0,
//            "clouds_low": 26,
//            "clouds_mid": 4,
//            "datetime": "2022-10-10",
//            "dewpt": 9.6,
//            "high_temp": 20.9,
//            "low_temp": 8.1,
//
