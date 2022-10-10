//
//  NetworkController.swift
//  Forecast_Codable
//
//  Created by Esther on 10/10/22.
//

import Foundation

class NetworkController {
    
    // MARK: - URL
    private static let baseURLString = "https://api.weatherbit.io/v2.0"
    // URL Keys
    private static let kForecastComponent = "forecast"
    private static let kDailyComponent = "daily"
    private static let kCityNameKey = "city"
    private static let kCityNameValue = "San_Francisco"
    private static let kAPIKeyKey = "key"
    private static let kAPIKeyValue = "b0fcfb58c07647108ddd948650e5ef64"
    
    
    // MARK: - Helper Functions: (Fetch)
    static func fetchDays(completion: @escaping ([Day]?) -> Void) {
        // Step One: Create URL
        guard let baseURL = URL(string: baseURLString) else {completion(nil); return}
        let forecastURL = baseURL.appendingPathComponent(kForecastComponent)
        let dailyURL = forecastURL.appendingPathComponent(kDailyComponent)
        // Query Items URLComponent Struct
        var urlComponents = URLComponents(url: dailyURL, resolvingAgainstBaseURL: true)
        // Query Item:
        let keyQuery = URLQueryItem(name: kAPIKeyKey, value: kAPIKeyValue)
        let cityQuery = URLQueryItem(name: kCityNameKey, value: kCityNameValue)
        urlComponents?.queryItems = [keyQuery, cityQuery]
        
        guard let finalURL = urlComponents?.url else { completion(nil); return }
        
        print (finalURL)
        
        // Step Two: Start Data Task to Retrieve Data
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            if let error {
                print("There was an error with the data task", error.localizedDescription)
            }
            // Check for Data
            guard let data = dTaskData else { completion(nil); return }
            // Do/Try/Catch
            do {
                let forecastData = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(forecastData.days)
            }
            catch {
                print("Error in Do/Try/Catch: \(error.localizedDescription)")
                completion(nil); return
            }
            
        } .resume()
        
    } // End of fetchDays

} // End of Class
