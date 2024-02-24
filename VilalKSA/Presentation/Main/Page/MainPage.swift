//
//  MainPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI
import GoogleMaps
import CoreLocation


struct MainPage: View {
    
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var selectedAddress: String?
    
    let locations: [Location] = [
        Location(latitude: 24.7136, longitude: 46.6753), // Central Riyadh
        Location(latitude: 24.7099, longitude: 46.6695), // Near King Fahd Road
        Location(latitude: 24.7241, longitude: 46.7079), // Near King Abdullah Park
        Location(latitude: 24.6880, longitude: 46.7228), // Near Al Nakheel Mall
        Location(latitude: 24.6996, longitude: 46.6854), // Near Riyadh Gallery Mall
        Location(latitude: 24.7124, longitude: 46.6743), // Slightly west of central Riyadh
        Location(latitude: 24.7135, longitude: 46.6755), // Very close to central Riyadh
        Location(latitude: 24.7253, longitude: 46.6824), // Near the Ministry of Interior
        Location(latitude: 24.6902, longitude: 46.6844), // Near Imam Muhammad ibn Saud Islamic University
        Location(latitude: 24.7565, longitude: 46.6404)  // North of Riyadh, near King Salman Park
    ]
    
    
    var body: some View {
        
        GoogleMapsView(locationManager: locationManager, locations: locations)
            .edgesIgnoringSafeArea(.all)
//        ShowLocationOnGoogleMapsView(locationManager: locationManager, lat: "24.6996", lng: "46.6854")
//            .edgesIgnoringSafeArea(.all)
//        VStack{
//        SelectedLocationGoogleMapsView(locationManager: locationManager, didSelectLocation: { location, address in
//            selectedLocation = location
//            selectedAddress = address
//            // Use selectedLocation and selectedAddress in another logic here
//        })
//        .edgesIgnoringSafeArea(.all)
//        
//        if let selectedLocation = selectedLocation, let selectedAddress = selectedAddress {
//            Text("Selected Location: \(selectedLocation.latitude), \(selectedLocation.longitude)")
//            Text("Selected Address: \(selectedAddress)")
//        }
//    }
    }
}
