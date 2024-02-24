//
//  LocationManager.swift
//  VilalKSA
//
//  Created by Elkilany on 22/02/2024.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    @Published var lastLocation: CLLocationCoordinate2D?
    @Published var lastSelectedAddress: String? = nil
    @Published var shouldFollowUserLocation: Bool = true
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            print("Location access denied or restricted")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location access granted")
            locationManager.startUpdatingLocation()
        default:
            print("Unhandled case")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.lastLocation = location.coordinate
        }
    }
    
}
