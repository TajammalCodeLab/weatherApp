//
//  LocationManagerModel.swift
//  weatherApp
//
//  Created by SID on 23/09/2024.
//

import Foundation
import CoreLocation


class LocationManagerModel{
    
    
    // MARK: - Variables -
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var location = CLLocation()
    var placemark:CLPlacemark?

}

