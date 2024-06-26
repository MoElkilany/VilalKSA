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
                                              zoom: 10)
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
                
                if let error = error {
                    print("Reverse geocoding failed: \(error.localizedDescription)")
                          return
                      }
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
}  // 2 locations


struct ShowLocationOnGoogleMapsView: UIViewRepresentable {
    
    @ObservedObject var locationManager: LocationManager
    var lat:Double
    var lng:Double
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 10)
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
}    // 3 locations


struct GoogleMapsView: UIViewRepresentable {
  
    @ObservedObject var locationManager: LocationManager
    var locations: [MainAdsResponse]
    @Binding var selectedPlace: MainAdsResponse?
    var isUpdated = false
    var isSelectAd: ((String,Bool)->Void)
    var removeMarker = false

    init(removeMarker: Bool ,locationManager: LocationManager, locations: [MainAdsResponse], selectedPlace: Binding<MainAdsResponse?>, isUpdated: Bool = false, isSelectAd: @escaping (String,Bool) -> Void) {
        self.locationManager = locationManager
        self.locations = locations
        self._selectedPlace = selectedPlace
        self.isUpdated = isUpdated
        self.isSelectAd = isSelectAd
        self.removeMarker = removeMarker
    }
    
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.lastLocation?.latitude ?? 24.7136,
                                              longitude: locationManager.lastLocation?.longitude ?? 46.6753,
                                              zoom: 10)
        mapView.camera = camera
        mapView.frame = CGRect.zero
        mapView.delegate = context.coordinator
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        mapView.padding = padding
        
        for marker in locations {
            let customMarker = PlaceMarker(response: marker)
            customMarker.map = mapView
        }
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if isUpdated {
            mapView.clear()
           for location in locations {
               let marker = PlaceMarker(response: location)
               marker.map = mapView
           }
        }
    }
    
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapsView
        
        init(_ parent: GoogleMapsView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            if parent.removeMarker == true {
                parent.selectedPlace = nil
            }
            parent.selectedPlace = nil
        }
        
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            parent.locationManager.shouldFollowUserLocation = false
        }
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            
            if let placeMarker = marker as? PlaceMarker, let response = placeMarker.mainAdsResponse {
                placeMarker.updatePriceLabelColor()
                parent.selectedPlace = response
                print("the response is ",response)
                parent.isSelectAd(String(response.id ?? 0 ), response.isSelected ?? true  )
            }
            return true
        }
    }
}   // 1 locations


struct ShowGoogleMapsView: UIViewRepresentable {
    
    @ObservedObject var locationManager: LocationManager
   
  
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.lastLocation?.latitude ?? 24.7136,
                                              longitude: locationManager.lastLocation?.longitude ?? 46.6753,
                                              zoom: 10)
        mapView.camera = camera
        mapView.frame = CGRect.zero
        mapView.delegate = context.coordinator
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        mapView.padding = padding
        
    
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: ShowGoogleMapsView
        
        init(_ parent: ShowGoogleMapsView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        }
        
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            parent.locationManager.shouldFollowUserLocation = false
        }
        
    }
}   // 1 locations


struct Location {
    let latitude: Double
    let longitude: Double
}
