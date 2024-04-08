//
//  SearchByAddress.swift
//  VilalKSA
//
//  Created by Elkilany on 12/03/2024.
//

import SwiftUI
import GooglePlaces

struct SearchByAddressPage: View {
    
    @State private var searchText = ""
    var onClose: () -> Void
    var onDismiss: (String, CLLocationCoordinate2D) -> Void
    
    
    var body: some View {
        ActionSheetView(bgColor: .white) {
            
                ScrollView {
                    
                    VStack{
                        HStack{
                            TextBold18(textKey: R.string.localizable.select_Your_Location.localized, textColor: R.color.colorPrimary.name.getColor())
                            Spacer()
                        }

                        HStack {
                            TextField(R.string.localizable.search_by_Title_or_City.localized, text: $searchText)
                                .padding(8)
                                .font(Font.custom(FontName.cairoRegular.rawValue, size: 15))
                                .foregroundColor(R.color.colorPrimary.name.getColor())
                                .padding(.horizontal, 24)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    HStack {
                                        Button(action: {
                                           
                                        }, label: {
                                            Image(systemName: "magnifyingglass")
                                                .foregroundColor(R.color.colorPrimary.name.getColor())
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                                .padding(.trailing, 8)
                                        })
                                    }
                                )
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                            
                            if !searchText.isEmpty {
                                Button(action: {
                                    self.searchText = ""
                                }) {
                                    TextRegular12(textKey:R.string.localizable.cancel.localized,textColor: R.color.colorPrimary.name.getColor())
                                }
                                .padding(.trailing, 10)
                            }
                        }
                        .frame(height: 70)
                        .padding(.horizontal)
//                        VilalDivider()
                        
//                        ContentViews()
                
                        VilalDivider()
                        
                        HStack{
                            DefaultBoarderButtonWithIcon(title: R.string.localizable.apply.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
//                                self.onDismiss(searchText)
                                searchPlaces(query: searchText)
//                                self.onClose()
                            })
                            .frame(height: 50)
                            
                            DefaultBoarderButtonWithIcon(title: R.string.localizable.cancel.localized,borderColor: .clear ,backgroundColor:R.color.colorF5F5F5.name.getColor(), titleColor:R.color.color42526E.name.getColor() ,actionButton: {
                                self.onClose()
                            })
                            .frame(height: 50)
                        }
                        .padding(.top)

                    }
                    .padding(.horizontal,20)
                }
            }
//        .frame( height: 350)
      
    }
    
    
    
    
    private func searchPlaces(query: String) {
           let filter = GMSAutocompleteFilter()
           filter.type = .noFilter  // Adjust filters as needed
           
           GMSPlacesClient.shared().findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { (results, error) in
               guard error == nil else {
                   print("Autocomplete error: \(error!.localizedDescription)")
                   return
               }
               
               if let result = results?.first {
                   fetchCoordinatesOf(placeID: result.placeID)
               }
           }
       }
       
       private func fetchCoordinatesOf(placeID: String) {
           GMSPlacesClient.shared().fetchPlace(fromPlaceID: placeID, placeFields: .coordinate, sessionToken: nil) { (place, error) in
               guard let place = place, error == nil else {
                   print("Fetch place error: \(error!.localizedDescription)")
                   return
               }
               
               DispatchQueue.main.async {
                   // Assuming onDismiss now also takes coordinates to pass back
                   self.onDismiss(searchText, place.coordinate)
                   self.onClose()
               }
           }
       }
    
    
   /*
    let placeFields: GMSPlaceField = [.name, .formattedAddress]
    placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
      guard let strongSelf = self else {
        return
      }

      guard error == nil else {
        print("Current place error: \(error?.localizedDescription ?? "")")
        return
      }

      guard let place = placeLikelihoods?.first?.place else {
        strongSelf.nameLabel.text = "No current place"
        strongSelf.addressLabel.text = ""
        return
      }

      strongSelf.nameLabel.text = place.name
      strongSelf.addressLabel.text = place.formattedAddress
    }
  }
*/
    
}



import SwiftUI
import GoogleMaps
import GooglePlaces

struct MapViewPlaces: UIViewRepresentable {
    let placeName: String
    @Binding var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update the map camera to focus on the new coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15)
        uiView.animate(to: camera)
        
        // Optionally, clear existing markers and add a new marker at the new coordinate
        uiView.clear()
        let marker = GMSMarker(position: coordinate)
        marker.map = uiView
    }
    
    static func searchForPlace(placeName: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter  // Adjust according to your needs
        
        GMSPlacesClient.shared().findAutocompletePredictions(fromQuery: placeName,
                                                              filter: filter,
                                                              sessionToken: nil) { (results, error) in
            if let error = error {
                print("Autocomplete error: \(error)")
                completion(nil)
                return
            }
            
            guard let result = results?.first else {
                print("No results found.")
                completion(nil)
                return
            }
            
            // Fetching details for the first result
            GMSPlacesClient.shared().fetchPlace(fromPlaceID: result.placeID,
                                                placeFields: .coordinate,
                                                sessionToken: nil) { (place, error) in
                if let error = error {
                    print("Error fetching place details: \(error)")
                    completion(nil)
                    return
                }
                
                guard let place = place else {
                    print("No place details found.")
                    completion(nil)
                    return
                }
                
                completion(place.coordinate)
            }
        }
    }
}

struct ContentViews: View {
    @State private var searchText: String = ""
    @State private var coordinate = CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093) // Default location
    
    var body: some View {
        VStack {
            TextField("Search Place", text: $searchText)
                .padding()
            
            Button("Search") {
                MapViewPlaces.searchForPlace(placeName: searchText) { newCoordinate in
                    if let newCoordinate = newCoordinate {
                        self.coordinate = newCoordinate
                    }
                }
            }
            
            MapViewPlaces(placeName: searchText, coordinate: $coordinate)
                .frame(height: 300)
        }
    }
}
