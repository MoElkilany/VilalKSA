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
    @EnvironmentObject var pilot: UIPilot<MainDestination>
    @StateObject var viewModel = MainViewModel()

    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var selectedAddress: String?
    @State private var selectedPlace: MainAdsResponse?
    @State var mainAds: [MainAdsResponse] = []
    @State var actionSheets = ActionSheetsState()
    @State var isUpdate: Bool = false
    @State var categorysList: [LookUpModel] = []
    @State var mainAdRequest: MainAdRequest?
    @State var savedCategory: String = ""
    
    
    var body: some View {
        
        ZStack{
            ZStack {
                if self.mainAds.isEmpty != true {
                    ZStack{
                        GoogleMapsView(locationManager: locationManager, locations: self.mainAds, selectedPlace: $selectedPlace, isUpdated: self.isUpdate, isSelectAd: { (adId,isSelected) in
                            if isSelected == false {
                                self.viewModel.isSelectedAdAPI(id:adId)
                            }
                        })
                      
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
                }else{
                    ShowGoogleMapsView(locationManager: locationManager)
              
                }
                
                HStack{
         
//                        RentalFilterView()
//                        .padding(.horizontal,12)
//                        .cornerRadius(12)

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
                        PropertyContainerView(imageUrl: item.image ?? "" , rate: String(item.rate ?? 0), category: item.category ?? "", name: item.name ?? "" , room: item.room ?? "" , space: item.estateSpace ?? "" , price: item.price ?? "" ,favourite: item.favourite ?? false , location: item.address, rental: item.rental ?? "", addOrRemoveFavouriteAction: {
                            self.viewModel.addOrRemoveFav(id: String(item.id ?? 0))
                        })
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                    })
                }
            }
            .disabled(self.viewModel.state == .loading)

            if self.viewModel.state == .loading {
                OnScreenLoading
            }
        }
        .onAppear {
            self.isUpdate = true
            if viewModel.categorysList.isEmpty {
                self.viewModel.getMainCategory()
            }
            self.viewModel.getMainAds(request: MainAdRequest(categoryID: "", lat: "", lon: "", price: "", room: "", bathrooms: "", lounges: "", sort: "") )
        }
        .onReceive(self.viewModel.$mainAdsList) { mainAdsList in
            self.mainAds = mainAdsList
            self.isUpdate = false
        }
        .onReceive(self.viewModel.$categorysList) { category in
            self.categorysList = category
        }
        
        .onReceive(viewModel.$isFinishedFetch) { finish in
            if finish == true {
                self.isUpdate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.isUpdate = false
                }
            }
        }
        
        .popup(isPresented: $actionSheets.showingFirst) {
            MainFilterPage(savedData:self.mainAdRequest ,savedCategory:self.savedCategory ,categorysList: self.categorysList, onClose: {
                actionSheets.showingFirst = false
                self.mainAdRequest = nil
                self.savedCategory = ""
                self.viewModel.getMainAds(request: MainAdRequest(categoryID: "", lat: "", lon: "", price: "", room: "", bathrooms: "", lounges: "", sort: "") )
            }, onDismiss: { mainAdRequest,savedCategory in
                self.savedCategory = savedCategory
                self.mainAdRequest = mainAdRequest
                self.viewModel.getMainAds(request: mainAdRequest )
                
            }, onCloseAfterSearch: {
                actionSheets.showingFirst = false
                
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

