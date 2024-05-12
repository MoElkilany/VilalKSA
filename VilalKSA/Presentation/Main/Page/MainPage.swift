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
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(R.color.color172B4D.name.getColor())
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.white], for: .selected)
        UISegmentedControl.appearance().backgroundColor = .white

    }
    
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
    @State var isTaskDone = false
    @State  var openPlacesSheet: Bool = false
    @State  var selectedCategory: String = ""
    @State  var selectedCategoryID: String = ""
    @State  var selectedFilterID: String = ""
    @State  var removeMarker: Bool = false


    var body: some View {
        
        ZStack{
            ZStack {
                if self.mainAds.isEmpty != true {
                    ZStack{
                        GoogleMapsView(removeMarker:removeMarker,locationManager: locationManager, locations: self.mainAds, selectedPlace: $selectedPlace, isUpdated: self.isUpdate, isSelectAd: { (adId,isSelected) in
                            if isSelected == false {
                                self.viewModel.isSelectedAdAPI(id:adId)
                            }
                        })
                      
                        .edgesIgnoringSafeArea(.all)
                        .padding(.bottom,10)
                        HStack{
                            Button {
                                self.removeMarker = true
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
                
                VStack(spacing:8){
                    HStack{
                        SegmentedView(getFilterID: { id in
                            selectedFilterID = id
                            self.viewModel.getMainAds(request: MainAdRequest(categoryID:selectedCategoryID, lat: "", lon: "", price: "", room: "", bathrooms: "", lounges: "", sort: "",type:selectedFilterID))
                        })
                            .customCardStyle2(corner: 12)
                            .padding(.leading,10)
                        Spacer()
                        Button {
                            actionSheets.showingFirst = true
                            //                   isTaskDone = true
                        } label: {
                            Image(R.image.filterIcon.name)
                                .padding(.trailing)
                        }
                    }
                    //   .sensoryFeedback(.success, trigger: isTaskDone)
                    Button {
                        openPlacesSheet = true
                    } label: {
                        VStack{
                            sheetView(text: $selectedCategory, placeholder: R.string.localizable.desired_Property_Type.localized)
                            .disabled(true)
                        }
                    }
                }
                .padding(.top,-320)
                
                
                if let item = selectedPlace {
                    Button(action: {
                        self.removeMarker = true
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
                ProgressView().progressViewStyle(CircularProgressViewStyle())
                    .controlSize(.extraLarge)
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
        
        .sheet(isPresented: $openPlacesSheet) {
            NavigationView {
                    List{
                        ForEach(self.viewModel.categorysList  ,id: \.self) { item in
                            Button(action: {
                                openPlacesSheet = false
                                selectedCategory = item.name ?? ""
                                selectedCategoryID = String(item.id ?? 0)
                                if selectedCategoryID == "0" {
                                    selectedCategoryID = ""
                                }
                                self.viewModel.getMainAds(request: MainAdRequest(categoryID:selectedCategoryID , lat: "", lon: "", price: "", room: "", bathrooms: "", lounges: "", sort: "",type:selectedFilterID) )

                            }, label: {
                                HStack{
                                    TextBold14(text:item.name ?? "", textColor: R.color.colorPrimary.name.getColor())
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                            })
                            .padding()
                        }
                    }
            }
            .multilineTextAlignment(.center)
            .presentationDetents([.medium, .large])
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

