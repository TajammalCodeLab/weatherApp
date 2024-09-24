
//
//  ViewController.swift
//  weatherApp
//
//  Created by SID on 20/09/2024.
//

import UIKit
import CoreLocation



class WeatherDetailsViewController: UIViewController {

    // MARK: - Outlets -
    
    @IBOutlet weak var locationNameLBL: UILabel!
    @IBOutlet weak var tempLBL: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    /// BOXES DETAILS
    @IBOutlet weak var windSpeedLBL: UILabel!
    @IBOutlet weak var humidityLBL: UILabel!
    @IBOutlet weak var pressureLBL: UILabel!
    @IBOutlet weak var visibilityLBL: UILabel!
    
    /// UIViews Cards
    @IBOutlet weak var wView: UIView!
    @IBOutlet weak var hView: UIView!
    @IBOutlet weak var pView: UIView!
    @IBOutlet weak var vView: UIView!
    // MARK: - Variables -
    private var mViewModel = LocationManagerModel()
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        cardShadow()
        
    }
    
    // MARK: - Override -
    // MARK: - IBAction -
    
    @IBAction func refreshBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: StringConstants.permissionTitle, message: StringConstants.alertLoactionMessage, preferredStyle: UIAlertController.Style.alert)
        
        let wantToshareAction = UIAlertAction(title: StringConstants.getLoactionActionTitle, style: .default) { (action) in
            self.getLocation()
        }
        
        let cancelAction = UIAlertAction(title: StringConstants.CancelLoactionActionTitle, style: .cancel) { (action) in
            self.mViewModel.locationManager.stopUpdatingLocation()
        }
        
        alert.addAction(wantToshareAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Obj -
    // MARK: - Method -
    
    func fetchWeatherData() {
       
        NetworkServices.shared.getWeather { [weak self] weatherData in
            self?.upDateUI(with: weatherData)
        }
    }
    
    func getLocation() {
        
        let aurthorizedStatus = mViewModel.locationManager.authorizationStatus
        switch aurthorizedStatus {
        case .notDetermined:
            mViewModel.locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            startUpdatingLocationManager()
        case .denied, .restricted:
            LocationServiceDeniedError()
        default:
            break
        }
    }
    
    func LocationServiceDeniedError() {
        
        let alert = UIAlertController(title: StringConstants.alertTitle, message: StringConstants.alertMessage, preferredStyle: UIAlertController.Style.alert)
        let settingAction = UIAlertAction(title: StringConstants.settingActionTitle, style: .default) { (action) in
            
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
               UIApplication.shared.open(settingsUrl)
             }
        }
        
        let cancelAction = UIAlertAction(title: StringConstants.cancelActionTitle, style: .cancel, handler: nil)
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func startUpdatingLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            mViewModel.locationManager.delegate = self
            mViewModel.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            mViewModel.locationManager.startUpdatingLocation()
        }
    }
    
    func upDateUI(with weather: WeatherResponse) {
        
        /// Populating the data
        tempLBL.text = "\(weather.main?.temp ?? 0)"
        weatherCondition.text = weather.weather?[0].description
        windSpeedLBL.text = "\(weather.wind?.speed ?? 0)"
        humidityLBL.text = "\(weather.main?.humidity ?? 0)"
        pressureLBL.text = "\(weather.main?.pressure ?? 0)"
        let percentage = ((weather.visibility ?? 0) / (10000)) * 100
        visibilityLBL.text = "\(percentage)"
        locationNameLBL.text = (weather.name ?? StringConstants.noData) + ", " + (weather.sys?.country ?? StringConstants.noData)
        
    }
    func cardShadow() {
        /// adding shadow
        CustomCardViewController.shadowadding(cardView: wView)
        CustomCardViewController.shadowadding(cardView: pView)
        CustomCardViewController.shadowadding(cardView: vView)
        CustomCardViewController.shadowadding(cardView: hView)
    }


}


// MARK: - Extension for Location Delegate

extension WeatherDetailsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.mViewModel.location = location
            
            let latitude: Double = self.mViewModel.location.coordinate.latitude
            let longitude: Double = self.mViewModel.location.coordinate.longitude
            NetworkServices.shared.setLatitude(lat: String(latitude))
            NetworkServices.shared.setLongitude(long: String(longitude))
            getLocation()
            fetchWeatherData()
            
        }
        
        
        
    }
}

