//
//  SelectedLocationGoogleMapsView.swift
//  VilalKSA
//
//  Created by Elkilany on 22/02/2024.
//

import SwiftUI
import GoogleMaps
import CoreLocation

struct SelectedLocationGoogleMapsView: UIViewRepresentable {
    
    @ObservedObject var locationManager: LocationManager
    var didSelectLocation: ((CLLocationCoordinate2D, String) -> Void)?
    
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.lastLocation?.latitude ?? 24.7136,
                                              longitude: locationManager.lastLocation?.longitude ?? 46.6753,
                                              zoom: 15)
        mapView.camera = camera
        mapView.frame = CGRect.zero
        mapView.delegate = context.coordinator
        mapView.isMyLocationEnabled = true
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if locationManager.shouldFollowUserLocation  , let lastLocation = locationManager.lastLocation {
            let cameraUpdate = GMSCameraUpdate.setTarget(lastLocation, zoom: mapView.camera.zoom)
            mapView.animate(with: cameraUpdate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: SelectedLocationGoogleMapsView
        
        init(_ parent: SelectedLocationGoogleMapsView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            
            parent.locationManager.shouldFollowUserLocation = false
            
            mapView.clear()
            let marker = GMSMarker(position: coordinate)
            marker.icon =  UIImage(named: R.image.mapLogo.name)!
            marker.map = mapView
            
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            
            
            let locale = Locale(identifier: "ar")
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
                if let placemark = placemarks?.first {
                    DispatchQueue.main.async {
                        let address = (placemark.name ?? "") + " " + (placemark.subLocality ?? "" )
                        let fullAddress = address + " " + (placemark.locality ?? "")
                        print("the fullAddress  \(fullAddress)" )
                        self.parent.didSelectLocation?(coordinate, fullAddress)
                    }
                }
            }
        }
    }
}



struct ShowLocationOnGoogleMapsView: UIViewRepresentable {

    @ObservedObject var locationManager: LocationManager
    var lat:Double
    var lng:Double
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: lng,
                                              zoom: 12)
        mapView.camera = camera
        
        mapView.frame = CGRect.zero
        mapView.delegate = context.coordinator
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat  , longitude:  lng  ))
        marker.icon =  UIImage(named: R.image.mapLogo.name)!
        marker.map = mapView
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: ShowLocationOnGoogleMapsView
        
        init(_ parent: ShowLocationOnGoogleMapsView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            parent.locationManager.shouldFollowUserLocation = false
         
        }
    }
}



struct GoogleMapsView: UIViewRepresentable {
    
    @ObservedObject var locationManager: LocationManager
    var locations: [Location]
    
    init(locationManager: LocationManager, locations: [Location]) {
        self.locationManager = locationManager
        self.locations = locations
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.lastLocation?.latitude ?? 24.7136,
                                              longitude: locationManager.lastLocation?.longitude ?? 46.6753,
                                              zoom: 15)
        mapView.camera = camera
        mapView.frame = CGRect.zero
        mapView.delegate = context.coordinator
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        for location in locations {
             let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
             marker.icon =  UIImage(named: R.image.mapLogo.name)!
             marker.map = mapView
         }
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
//        if locationManager.shouldFollowUserLocation, let lastLocation = locationManager.lastLocation {
//            let cameraUpdate = GMSCameraUpdate.setTarget(lastLocation, zoom: mapView.camera.zoom)
//            mapView.animate(with: cameraUpdate)
//        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapsView
        
        init(_ parent: GoogleMapsView) {
            self.parent = parent
        }
        
//        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//            
//            parent.locationManager.shouldFollowUserLocation = false
//         
//        }
        
        
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            parent.locationManager.shouldFollowUserLocation = false
        }
    }
}


struct Location {
    let latitude: Double
    let longitude: Double
}
