//
//  PlaceMarker.swift
//  VilalKSA
//
//  Created by Elkilany on 24/02/2024.
//
// MKPointAnnotation
import GoogleMaps
import  UIKit
import MapKit

class PlaceMarker: GMSMarker {
    var mainAdsResponse: MainAdsResponse?
    
    init(response: MainAdsResponse) {
        super.init()
        self.mainAdsResponse = response
        if let lat = Double(response.lat ?? "0.0"), let long = Double(response.lon ?? "0.0") {
            self.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        self.snippet = "\(response.id ?? 0)"
        
        let view = Bundle.main.loadNibNamed("MarkerInfoView", owner: nil, options: nil)?.first as! MarkerInfoView
        view.priceLab.text = (response.price ?? "") + " " + "ألف"
        view.containerView.layer.cornerRadius = 4
        iconView = view
        appearAnimation = .pop
        
//        if mainAdsResponse?.isSelected == true  {
//            view.containerView.backgroundColor = UIColor(named: "Color868583")
//            view.priceLab.textColor = .white
//            view.layoutIfNeeded()
//        }
    }
    
    
    func updatePriceLabelColor() {
           if let view = self.iconView as? MarkerInfoView {
               view.containerView.backgroundColor = UIColor(named: "Color868583")
               view.priceLab.textColor = .white
               view.layoutIfNeeded()
           } else {
               print("Error: iconView is not a MarkerInfoView. Cannot update price label color.")
           }
       }
    
    
}



class PlaceMarkers: MKPointAnnotation {
    var mainAdsResponse: MainAdsResponse?
    
    init(response: MainAdsResponse) {
        super.init()
        self.mainAdsResponse = response
        self.title = response.name // Use the title property for the name
        self.subtitle = "\(response.id ?? 0)" // Use the subtitle property for the ID
        
        if let lat = Double(response.lat ?? "0.0"), let lon = Double(response.lon ?? "0.0") {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
    }
}
