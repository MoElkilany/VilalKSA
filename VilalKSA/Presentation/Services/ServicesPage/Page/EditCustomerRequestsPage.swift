//
//  EditCustomerRequestsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 21/04/2024.
//

import SwiftUI
import UIPilot
import LanguageManagerSwiftUI
import CoreLocation

struct EditCustomerRequestsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @StateObject var viewModel = AddCustomerRequestsViewModel()
    
    @State private var categoryId: String = ""
    @State private var categoryName: String = ""
    
    @State private var roomNumbers:  Int = 1
    @State private var livingRooms:  Int = 1
    @State private var bathRooms:    Int = 1
    @State private var streetView:   Int = 1
    @State private var propertyArea: String = ""
    
    @State private var floorNumber: Int  = 1
    @State private var propertyAge: Int  = 1

    @State private var furnished         = false
    @State private var kitchen           = false
    @State private var annex             = false
    @State private var carEntrance       = false
    @State private var elevator          = false
    @State private var waterAvailability = false
    @State private var airConditioning   = false
    
    @State private var specialSurface    = false
    @State private var villa             = false
    @State private var twoEntrances      = false
    @State private var privateEntrances  = false
    
    @State private var priceFrom: String = ""
    @State private var priceTo: String = ""
    @State private var propertyName: String = ""
    
    @State private var propertyDetails: String = ""
    @State private var interfaceId: String = ""
    @State private var openCategory: Bool = false
    @State private var categoryList: [AdsCategoryResponse]?
    
    @State private var rentalPeriodId: String = ""
    @State private var residentId: String = ""
    
    @State private var submitButton = false
    
    @State private var state: AppState = .success
    
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var selectedAddress: String?
    
    var body: some View {
        
        VilalKSAContainer(state: self.$state,titlePage: R.string.localizable.property_Request.localized, tryAgainAction: {
        },backAction:{
            pilot.pop()
        } ,content: {
            ZStack{
                ScrollView(showsIndicators: false){
                        VStack{
                            Button(action: {
                                openCategory = true
                            }, label: {
                                VStack(alignment: .leading,spacing: 0) {
                                    TextBold14(textKey: R.string.localizable.desired_Property_Type.localized, textColor: R.color.colorPrimary.name.getColor())
                                        .padding(.bottom,0)
                                    VilalTextField(text: $categoryName, placeholder:  R.string.localizable.desired_Property_Type.localized, imageName:R.image.arrowUp2.name , keyboardType: .default, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                        self.viewModel.isCategoryIdValid = isValid
                                    })
                                    .disabled(true)
                                }
                            })
                            VilalDivider()
                            VStack(alignment: .leading,spacing: 0) {
                                TextBold14(textKey: R.string.localizable.property_Name.localized, textColor: R.color.colorPrimary.name.getColor())
                                    .padding(.bottom,0)
                                VilalTextField(text: $propertyName, placeholder:  R.string.localizable.property_Name.localized, imageName:"" , keyboardType: .default, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                    self.viewModel.isPropertyNameValid = isValid
                                })
                            }
                            VilalDivider()
                            VStack(alignment: .leading,spacing: 0) {
                                TextBold14(textKey:R.string.localizable.property_Area.localized, textColor: R.color.colorPrimary.name.getColor())
                                    .padding(.bottom,0)

                                VilalTextField(text: $propertyArea, placeholder:   R.string.localizable.property_Area.localized , imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                    self.viewModel.isValidArea = isValid
                                })
                            }
                            
                            VilalDivider()
                            
                            PropertyInterfaceView(items: self.viewModel.adsInterfaceList, onSelected: { selectedID in
                                print("the selectedID is ", selectedID)
                                self.interfaceId = selectedID
                            })
                            if submitButton == true  {
                                if  self.interfaceId == "" {
                                    HStack{
                                        ErrorTextView(errorText: R.string.localizable.please_Select_Facade.localized)
                                        Spacer()
                                    }
                                }
                            }
                            
                            VilalDivider()
                            
                            ScrollCollectionView( title: R.string.localizable.rental_Duration.localized, items: self.viewModel.rentalPeriodList) { rentalPeriodId in
                                print("the rentalPeriodId is ", rentalPeriodId)
                                self.rentalPeriodId = rentalPeriodId
                            }
                            
                            if submitButton == true  {
                                if  self.rentalPeriodId == "" {
                                    HStack{
                                        ErrorTextView(errorText: R.string.localizable.please_Select_Rental_Duration.localized)
                                        Spacer()
                                    }
                                }
                            }
                            
                            VilalDivider()
                            
                            ScrollCollectionView(  title: R.string.localizable.resident.localized, items: self.viewModel.residentList) { residentId in
                                self.residentId = residentId
                            }
                            
                            if submitButton == true  {
                                if  self.residentId == "" {
                                    HStack{
                                        ErrorTextView(errorText: R.string.localizable.please_Select_Resident_Type.localized)
                                        Spacer()
                                    }
                                }
                            }
                            VilalDivider()
                            
                            
                            HStack{
                                VStack(alignment: .leading,spacing: 0) {
                                    TextBold14(textKey: R.string.localizable.price_From.localized, textColor: R.color.colorPrimary.name.getColor())
                                        .padding(.bottom,0)
                                    VilalTextField(text: $priceFrom, placeholder:  R.string.localizable.price_From.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                        self.viewModel.isPriceFromValid = isValid
                                    })
                                }
                                
                                VStack(alignment: .leading,spacing: 0) {
                                    TextBold14(textKey: R.string.localizable.price_To.localized, textColor: R.color.colorPrimary.name.getColor())
                                        .padding(.bottom,0)
                                    VilalTextField(text: $priceTo, placeholder:  R.string.localizable.price_To.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                        self.viewModel.isPriceToValid = isValid
                                    })
                                }
                            }
                            VilalDivider()
                            
                            
                            SliderView(sliderValue: $roomNumbers, localizedTitle:  R.string.localizable.rooms.localized, localizedKey: "",valueFrom: 1,valueTo: 50)
                            VilalDivider()
                            SliderView(sliderValue: $livingRooms, localizedTitle:  R.string.localizable.living_Rooms.localized, localizedKey: "",valueFrom: 1,valueTo: 4)
                            VilalDivider()
                            SliderView(sliderValue: $bathRooms, localizedTitle:  R.string.localizable.bathrooms.localized, localizedKey: "",valueFrom: 1,valueTo: 6)
                            VilalDivider()
                            SliderView(sliderValue: $streetView, localizedTitle:  R.string.localizable.street_View.localized, localizedKey: R.string.localizable.meter.localized,valueFrom: 10,valueTo: 100)
                            VilalDivider()
                            
                            PlusMinusView(localizedTitle:  R.string.localizable.floor_Number.localized, defualtValue: 1, finalValue: { floorNumber in
                                self.floorNumber = floorNumber
                            })
                            VilalDivider()
                            PlusMinusView(localizedTitle:  R.string.localizable.property_Age.localized, defualtValue: 1, finalValue: { propertyAge in
                                self.propertyAge = propertyAge
                            })
                            
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.furnished.localized, switchValue: $furnished)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.kitchen.localized, switchValue: $kitchen)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.annex.localized, switchValue: $annex)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.car_Entrance.localized, switchValue: $carEntrance)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.water_Availability.localized, switchValue: $waterAvailability)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.elevator.localized, switchValue: $elevator)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.air_Conditioning.localized, switchValue: $airConditioning)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.private_Roof.localized, switchValue: $specialSurface)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.villa.localized, switchValue: $villa)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.two_Entries.localized, switchValue: $twoEntrances)
                            VilalDivider()
                            SwitchButtonView(localizedTitle:  R.string.localizable.private_Entry.localized, switchValue: $privateEntrances)
                            VilalDivider()
                                .padding(.bottom,8)
                            
                            VStack(alignment: .leading,spacing: 0) {
                                TextBold14(textKey: R.string.localizable.property_Details.localized, textColor: R.color.colorPrimary.name.getColor())
                                    .padding(.bottom,4)
                                
                                MultilineTextField(text: $propertyDetails, submitButton: submitButton, placeholder: R.string.localizable.property_Details.localized,borderColor: .gray.opacity(0.5)) { isValid in
                                    self.viewModel.isPropertyDetailsValid = isValid
                                }
                            }
                            
                        }
                        
                      
                    GeometryReader { geometry in
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.property_Location.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,4)
                            
                            SelectedLocationGoogleMapsView(locationManager: locationManager, didSelectLocation: { location, address in
                                selectedLocation = location
                                selectedAddress = address
                            })
                            .frame(width: geometry.size.width, height: 300)
                            .padding(4)
                            .cornerRadius(50)
                        }
                  }
                    .padding(.bottom,350)
                    
                    if  submitButton == true {
                        if selectedLocation == nil {
                            HStack{
                                ErrorTextView(errorText: R.string.localizable.please_Select_Property_Location.localized)
                                Spacer()
                            }
                        }
                    }
                    
                    DefaultButton(title:  R.string.localizable.property_Request.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        
                        submitButton = true

                        if viewModel.isValidForm() {
                            let requestModel = CreateCutomerRequestModel(typeId: "1", categoryId: self.categoryId, lat: String(self.selectedLocation?.latitude ?? 21.11), lon: String(self.selectedLocation?.longitude ?? 21.11), interfaceId: self.interfaceId, room:String(self.roomNumbers), lounges: String(self.livingRooms), bathrooms: String(self.bathRooms), space: String(self.streetView), estateSpace: self.propertyArea, floorNumber: String(self.floorNumber), ageRealEstate: String(self.propertyAge), airConditioners: String(Convert.boolValueToIntValue(boolValue: self.airConditioning)), specialSurface: String(Convert.boolValueToIntValue(boolValue: self.specialSurface)), villa: String(Convert.boolValueToIntValue(boolValue: self.villa)), twoEntrances: String(Convert.boolValueToIntValue(boolValue: self.twoEntrances)), privateEntrance: String(Convert.boolValueToIntValue(boolValue: self.privateEntrances)), info: self.propertyDetails, furnished: String(Convert.boolValueToIntValue(boolValue: self.furnished)), kitchen: String(Convert.boolValueToIntValue(boolValue: self.kitchen)), appendix: String(Convert.boolValueToIntValue(boolValue: self.annex)), carEntrance: String(Convert.boolValueToIntValue(boolValue: self.carEntrance)), elevator: String(Convert.boolValueToIntValue(boolValue: self.elevator)), price: self.priceFrom, rentalperiodID: self.rentalPeriodId, residentID: self.residentId, imageAds: "0" ,name: self.propertyName,address: self.selectedAddress ?? "" )
                            self.viewModel.createNewRequest(model: requestModel)
                        }
                        
                    }, fontWeight: .bold)
                }
                .disabled(self.viewModel.createAdsState == .loading)
                
                if self.viewModel.createAdsState == .loading {
                    OnScreenLoading
                }
            }
            
            .padding(.horizontal,25)
            .edgesIgnoringSafeArea(.all)
            .padding(.top,20)
            .padding(.bottom,20)
            .onReceive(self.viewModel.$adsCategoryList, perform: { categories in
                self.categoryList = categories
            })
            .onReceive(self.viewModel.$state, perform: { state in
                self.state = state
            })
            
            .onReceive(self.viewModel.$sucessAddRequest, perform: { sucess in
                if sucess == true {
                    pilot.push(.createAdsSuccessPage)
                }
            })
            .onAppear {
                self.viewModel.getAdsCategoryList()
                self.viewModel.getRentalPeriodList()
                self.viewModel.getResidentList()
                self.viewModel.getAdsInterfaceList()
            }
            .popup(isPresented: self.$viewModel.errorPopUp) {
                ErrorToast(title: self.viewModel.errorMessage)
            } customize: {
                $0
                    .type(.floater())
                    .position(.top)
                    .animation(.spring())
                    .autohideIn(5)
            }
            .sheet(isPresented: $openCategory) {
                NavigationView {
                    List{
                        ForEach( self.categoryList ?? []  ) { item in
                            Button(action: {
                                openCategory = false
                                categoryName = item.name ?? ""
                                categoryId = String(item.id ?? 0 )
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
//                .presentationDetents([.medium, .large])
            }
        })
    }
    
}

