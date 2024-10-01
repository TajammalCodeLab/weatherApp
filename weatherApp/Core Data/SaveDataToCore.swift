import UIKit
import CoreData

class SaveDataToCore {
    
    // MARK: - Save Weather Data -
    static func saveWeatherData(weather: WeatherResponse) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newWeatherData = weatherApp(context: context)
        
        newWeatherData.locationName = weather.name
        newWeatherData.weatherDescrip = weather.weather?.first?.description
        newWeatherData.windSpeed = "\(weather.wind?.speed ?? 0)"
        newWeatherData.humidity = Int32(weather.main?.humidity ?? 0)
        newWeatherData.pressure = Int32(weather.main?.pressure ?? 0)
        let visibilityPercentage = ((weather.visibility ?? 0) / 10000) * 100
        newWeatherData.visibility = Int32(visibilityPercentage)
    
        
        do {
            try context.save()
            print("Weather data saved!---------------------------------------")
            print("Loacation : \(String(describing: newWeatherData.locationName))")
            
        } catch {
            print("-------xxxxxxxxxxxxxxxxx----------------Failed to save weather data: \(error)")
        }
    }
    
    // MARK: - Fetch Saved Weather Data -
    static func fetchSavedWeatherData(onSuccess: @escaping (weatherApp?) -> Void) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = weatherApp.fetchRequest()
        
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
