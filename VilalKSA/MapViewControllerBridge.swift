//
//  MapViewControllerBridge.swift
//  VilalKSA
//
//  Created by Elkilany on 20/02/2024.
//

import SwiftUI
import GoogleMaps

struct MapViewControllerBridge: UIViewControllerRepresentable {

  func makeUIViewController(context: Context) -> MapViewController {
    // Replace this line
    return UIViewController() as! MapViewController
  }

  func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
  }
}



class MapViewController: UIViewController {

  let map =  GMSMapView(frame: .zero)
  var isAnimating: Bool = false

  override func loadView() {
    super.loadView()
    self.view = map
  }
}
