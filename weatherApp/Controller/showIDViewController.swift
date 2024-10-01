//
//  showIDViewController.swift
//  weatherApp
//
//  Created by SID on 28/09/2024.
//

import UIKit

class showIDViewController: UIViewController {

    //MARK: IBOutlets

    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherDescrip: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibilityValue: UILabel!
    @IBOutlet weak var pressureValue: UILabel!
    
    /// Card View
    @IBOutlet weak var windView: UIView!
    @IBOutlet weak var humiView: UIView!
    @IBOutlet weak var preView: UIView!
    @IBOutlet weak var visiView: UIView!
    @IBOutlet weak var mainView: UIView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        cardShadow()
    }
    
    // MARK: - Navigation

    func cardShadow() {
        
        CustomCardViewController.shadowadding(cardView: windView)
        CustomCardViewController.shadowadding(cardView: humiView)
        CustomCardViewController.shadowadding(cardView: preView)
        CustomCardViewController.shadowadding(cardView: visiView)
        CustomCardViewController.shadowadding(cardView: mainView)
    }

}
extension showIDViewController: FindWeatherDelegate {
    
    func findWeather(weather: WeatherResponse) {
        print("--------------" + "\(weather.main?.temp ?? 0)")
        
        temp.text = "\(weather.main?.temp ?? 0)"
        weatherDescrip.text = (weather.weather?[0].description ?? StringConstants.noData) + StringConstants.feelsLike + "\(weather.main?.feels_like ?? 0)"
        windSpeed.text = "\(weather.wind?.speed ?? 0)"
        humidity.text = "\(weather.main?.humidity ?? 0)"
        pressureValue.text = "\(weather.main?.pressure ?? 0)"
        let percentage = ((weather.visibility ?? 0) / (10000)) * 100
        visibilityValue.text = "\(percentage)"
        locationName.text = (weather.name ?? StringConstants.noData) + ", " + (weather.sys?.country ?? StringConstants.noData)
    }
    
    
}
