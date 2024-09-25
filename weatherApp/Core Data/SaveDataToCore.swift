//
//  SaveDataToCore.swift
//  weatherApp
//
//  Created by SID on 25/09/2024.
//

import Foundation
import CoreData
import UIKit

class SaveDataToCore {
    
    static func saveWeatherData(weather: WeatherResponse) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newWeatherData = LocationData(context: context)
        
        newWeatherData.locationName = weather.name ?? "N/A"
        newWeatherData.weatherDescrip = weather.weather?.first?.description ?? "N/A"
        newWeatherData.windSpeed = "\(weather.wind?.speed ?? 0)"
        newWeatherData.humidity = "\(weather.main?.humidity ?? 0)"
        newWeatherData.pressure = "\(weather.main?.pressure ?? 0)"
        let visibilityPercentage = ((weather.visibility ?? 0) / 10000) * 100
        newWeatherData.visibility = "\(visibilityPercentage)"
        
        do {
            try context.save()
            print("Weather data saved!")
        } catch {
            print("Failed to save weather data: \(error)")
        }
    }
    
    static func fetchSavedWeatherData(onSuccess: @escaping (LocationData?) -> Void) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = LocationData.fetchRequest()
        
        do {
            let savedWeatherData = try context.fetch(fetchRequest)
            if let lastSavedWeather = savedWeatherData.last {
                onSuccess(lastSavedWeather)
            } else {
                onSuccess(nil)
            }
        } catch {
            print("Failed to fetch saved weather data: \(error)")
            onSuccess(nil)
        }
    }
}

