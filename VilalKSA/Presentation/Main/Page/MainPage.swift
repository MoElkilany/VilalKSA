//
//  MainPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI
import GoogleMaps
import CoreLocation
import UIPilot

struct ActionSheetsState {
    var showingFirst = false
    var showingSearchFilter = false
}

struct MainPage: View {
    
    
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var selectedAddress: String?
    @StateObject var viewModel = MainViewModel()
    @State private var selectedPlace: MainAdsResponse?
    @State var mainAds: [MainAdsResponse] = []
    @EnvironmentObject var pilot: UIPilot<MainDestination>
    @State var actionSheets = ActionSheetsState()
    
    var body: some View {
            
        ZStack {
            
            if self.mainAds.isEmpty != true {
                ZStack{
                    
                    GoogleMapsView(locationManager: locationManager, locations: self.mainAds, selectedPlace: $selectedPlace)
                        .edgesIgnoringSafeArea(.all)
                        .padding(.bottom,10)
                    
                    HStack{
                        Button {
                            pilot.push(.mainListPage(mainAdsList: self.mainAds))
                        } label: {
                            Image(R.image.listLogo.name)
                                .frame(width: 40, height: 40, alignment: .center)
                                .padding(.horizontal,15)
                        }
                        Spacer()
                    }
                    .padding(.top,400)
                }
                .padding(.top,50)
            }
            
            
            HStack{
                Button {
                    actionSheets.showingSearchFilter = true
                } label: {
                    MainSearchView()
                        .padding(.leading)
                        .disabled(true)
                }
                Spacer()
                Button {
                    actionSheets.showingFirst = true
                } label: {
                    Image(R.image.filterIcon.name)
                        .padding(.horizontal)
                }
            }
            .padding(.top,-320)
            
            if let item = selectedPlace {
                
                Button(action: {
                    pilot.push(.adsDetailsPage(id: String(item.id ?? 0 ), type: .main))
                }, label: {
                    PropertyContainerView(imageUrl: item.image ?? "" , rate: String(item.rate ?? 0), category: item.category ?? "", name: item.name ?? "" , room: item.room ?? "" , space: item.estateSpace ?? "" , price: item.price ?? "" , favourite: item.favourite ?? false , location: item.address, rental: item.rental ?? "", addOrRemoveFavouriteAction: {
                        self.viewModel.addOrRemoveFav(id: String(item.id ?? 0))
                    })
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                })
            }
        }

        .task {
            self.viewModel.getMainAds(request: MainAdRequest(lat: "", lon: ""))
        }
        .onReceive(self.viewModel.$mainAdsList) { mainAdsList in
            self.mainAds = mainAdsList
        }
        
        .popup(isPresented: $actionSheets.showingFirst) {
            MainFilterPage(onClose: {
                print("onClose called")
                actionSheets.showingFirst = false
            }, onDismiss: { test in
                print("the test is ", test)
//                self.viewModel.getMainAds(request: MainAdRequest(lat: "", lon: ""))
            })
        } customize: {
            $0
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
        }
        
        .popup(isPresented: $actionSheets.showingSearchFilter) {
            SearchByAddressPage(onClose: {
                print("onClose called")
                actionSheets.showingSearchFilter = false
            }, onDismiss: { test,location  in
                print("the test is ", location)
            })
        } customize: {
            $0
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
        }
    }
}

