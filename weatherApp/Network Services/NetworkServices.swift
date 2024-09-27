//
//  NetworkServices.swift
//  weatherApp
//
//  Created by SID on 21/09/2024.
//

import Foundation

class NetworkServices{
    static let shared = NetworkServices()
    
    //MARK: Variables
    let URL_API_KEY = "2b913b87a44659c1f1262164cadc86df"
    var URL_LATITUDE = "" // from location manager
    var URL_LONGITUDE = "" // from location manager
    var URL_GET_ONE_CALL = ""
    var CITY_NAME = ""
    let URL_BASE = "https://api.openweathermap.org/data/2.5/weather?"
    let session = URLSession(configuration: .default)
    
    
    //MARK: Methods
    func buildURL() -> String {
        URL_GET_ONE_CALL = "lat=" + URL_LATITUDE + "&lon=" + URL_LONGITUDE + "&appid=" + URL_API_KEY + "&units=metric"
        return URL_BASE + URL_GET_ONE_CALL
    }
    
    func buildURLForCity() -> String {
        URL_GET_ONE_CALL = "q=" + CITY_NAME + "&appid=" + URL_API_KEY + "&units=metric"
        return URL_BASE + URL_GET_ONE_CALL
    }
    
    func setLatitude(lat: String){
        URL_LATITUDE = lat
    }
    
    func setLongitude(long: String){
        URL_LONGITUDE = long
    }
    func setCityNAme(CityName: String){
        CITY_NAME  = CityName
    }
    
    func getWeather(onSuccessResult: @escaping (WeatherResponse) -> Void) {
        guard let url = URL(string: buildURL()) else {
            print("Error building URL")
            return
        }
        print(buildURL())
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("dispatch"+"\(error.localizedDescription)")
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    print("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        onSuccessResult(items)
                    } else {
                        print("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    print("catch "+"\(error.localizedDescription)")
                }
            }
            
        }
        task.resume()
    }
    
    func getWeatherbyCity(onSuccessResult: @escaping (WeatherResponse) -> Void) {
        guard let url = URL(string: buildURLForCity()) else {
            print("Error building URL")
            return
        }
        print(buildURLForCity())
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("dispatch"+"\(error.localizedDescription)")
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    print("Invalid data or response")
                    return
                }
                
                print("JSON String: \(String(data: data, encoding: .utf8) ?? "NOTHING FOR DATA")")
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        onSuccessResult(items)

                        
                    } else {
                        print("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    print("catch "+"\(error.localizedDescription)")
                }
            }
            
        }
        task.resume()
    }
}
