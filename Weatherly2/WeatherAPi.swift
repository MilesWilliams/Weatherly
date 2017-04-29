//
//  weather.swift
//  Weatherly
//
//  Created by MIles Work on 2017/04/23.
//  Copyright © 2017 MIles Work. All rights reserved.
//

import Foundation

protocol WeatherApiDelegate {
    func didGetWeather(weather: Weather)
    func didNotGetWeather(error: NSError)

}

class WeatherApi {
    private var delegate: WeatherApiDelegate
    var finished = false
    var apiLaunched = false
    var weatherConditions: Array<Any> = []
    let url = URL(string:"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid=%201591691%20and%20u=%27c%27&format=json")
    
    // MARK: -
    
    init(delegate: WeatherApiDelegate) {
        self.delegate = delegate
    }

    func getWeather(url: URL) {
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) {
            (data:Data?, response:URLResponse?, error:Error?) in
            if let networkError = error {
                // Case 1: Error
                // An error occurred while trying to get data from the server.
                print("broken")
                self.delegate.didNotGetWeather(error: networkError as NSError)

            } else {
                print("It worked")
                
                do {

                    let wethData = try JSON(data:data!)
                    
                    let weather = Weather(weatherData: wethData)
                    
                    self.delegate.didGetWeather(weather: weather)

                }catch let jsonError as NSError {
                    self.delegate.didNotGetWeather(error: jsonError as NSError)
                }
            }
        }
        dataTask.resume()
//        return weatherConditions
    }
    
}
