//
//  AddNewAdsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 12/02/2024.
//

import SwiftUI
import UIPilot
import LanguageManagerSwiftUI

struct AddNewAdsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @StateObject var viewModel = AddNewAdsViewModel()
    @EnvironmentObject var loading: Loading
    
    var addNewAdRequestModel:AddNewAdRequestModel?
    
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
    //    @State private var villa             = false
    @State private var twoEntrances      = false
    @State private var privateEntrances  = false
    
    @State private var price: String = ""
    @State private var propertyDetails: String = ""
    @State private var interfaceId: String = ""
    @State private var propertyName: String = ""
    
    @State private var submitButton = false
    
    @State private var state: AppState = .success
    
    @State private var openResidentSheet: Bool = false
    
    @State private var residentName: String = ""
    
    @State private var openRentalSheet  : Bool = false
    @State private var rentalName: String = ""
    
    
    var body: some View {
        
        VilalKSAContainer(state: self.$state,titlePage: R.string.localizable.property_Details.localized, tryAgainAction: {
        },backAction:{
            pilot.pop()
        } ,content: {
            
            ZStack{
                ScrollView(showsIndicators: false){
                    VStack{
                        StepsBarView(stepNumber: "3", stepImage: R.image.step3_AddNewAds.name)
                            .padding(.horizontal, -10)
                        
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
                        
                        if addNewAdRequestModel?.addStatus == "0" {
                            VStack{
                                Button {
                                    openRentalSheet = true
                                } label: {
                                    VStack(spacing: 4){
                                        HStack{
                                            TextBold14(textKey:R.string.localizable.rental_Duration.localized, textColor: R.color.colorPrimary.name.getColor())
                                            Spacer()
                                        }
                                        
                                        VilalTextField(text: $rentalName, placeholder:  R.string.localizable.please_Select_Rental_Duration.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: false , onSubmit: { isValid in
                                        })
                                        .disabled(true)
                                        
                                        if submitButton == true  {
                                            if  self.rentalName == "" {
                                                HStack{
                                                    ErrorTextView(errorText: R.string.localizable.please_Select_Rental_Duration.localized)
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                }
                                .sheet(isPresented: $openRentalSheet) {
                                    NavigationView {
                                        List{
                                            ForEach(self.viewModel.rentalPeriodList ,id: \.self) { item in
                                                Button(action: {
                                                    openRentalSheet = false
                                                    self.rentalName = item.name ?? ""
                                                    viewModel.rentalID = String(item.id ?? 0)
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
//                                    .presentationDetents([.medium, .large])
                                }
                                VilalDivider()
                                Button {
                                    openResidentSheet = true
                                } label: {
                                    VStack(spacing: 4){
                                        HStack{
                                            TextBold14(textKey:R.string.localizable.resident.localized, textColor: R.color.colorPrimary.name.getColor())
                                            Spacer()
                                        }
                                        
                                        VilalTextField(text: $residentName, placeholder:  R.string.localizable.please_Select_Resident_Type.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: false , onSubmit: { isValid in
                                        })
                                        .disabled(true)
                                        
                                        if submitButton == true  {
                                            if  self.residentName == "" {
                                                HStack{
                                                    ErrorTextView(errorText: R.string.localizable.please_Select_Resident_Type.localized)
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                }
                                .sheet(isPresented: $openResidentSheet) {
                                    NavigationView {
                                        List{
                                            ForEach(self.viewModel.residentList ,id: \.self) { item in
                                                Button(action: {
                                                    openResidentSheet = false
                                                    self.residentName = item.name ?? ""
                                                    viewModel.residentID = String(item.id ?? 0)
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
//                                    .presentationDetents([.medium, .large])
                                }
                            }
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
                            print("the quantity value is,", floorNumber)
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
                        SwitchButtonView(localizedTitle:  R.string.localizable.two_Entries.localized, switchValue: $twoEntrances)
                        VilalDivider()
                        SwitchButtonView(localizedTitle:  R.string.localizable.private_Entry.localized, switchValue: $privateEntrances)
                            .padding(.bottom,8)
                        VilalDivider()
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: addNewAdRequestModel?.addStatus == "0" ?  R.string.localizable.price_For_One_Night.localized: R.string.localizable.price.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                            
                            VilalTextField(text: $price, placeholder:  addNewAdRequestModel?.addStatus == "0" ?  R.string.localizable.price_For_One_Night.localized: R.string.localizable.price.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                self.viewModel.isPriceValid = isValid
                            })
                        }
                        
                        VilalDivider()
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.property_Details.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                            
                            MultilineTextField(text: $propertyDetails, submitButton: submitButton, placeholder: R.string.localizable.property_Details.localized,borderColor: .gray.opacity(0.5)) { isValid in
                                self.viewModel.isPropertyDetailsValid = isValid
                            }
                        }
                    }
                    
                    DefaultButton(title:  R.string.localizable.add.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        submitButton = true
                        if self.viewModel.isValidForm() && self.interfaceId.isEmpty == false {
                            let requestModel = getRequestModel()
                            self.viewModel.createNewAds(video: self.addNewAdRequestModel?.videosData , images: addNewAdRequestModel?.images ?? [] , model: requestModel)
                        }
                        
                    }, fontWeight: .bold)
                    .padding(.bottom,20)
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
            .onReceive(self.viewModel.$state, perform: { state in
                self.state = state
            })
            .onReceive(self.viewModel.$sucessAddRequest, perform: { sucess in
                if sucess == true {
                    pilot.push(.createAdsSuccessPage)
                }
            })
            .onAppear {
                self.viewModel.getAdsInterfaceList()
                if addNewAdRequestModel?.addStatus == "0" {
                    self.viewModel.isRental = true
                    self.viewModel.getResidentList()
                    self.viewModel.getRentalPeriodList()
                }
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
        })
    }
    
    func getRequestModel() -> [String: String] {
        var requestModel: [String: String] = [:]
        requestModel["type_id"] = "2"
        requestModel["category_id"] = self.addNewAdRequestModel?.categoryAdID ?? ""
        requestModel["lat"] = self.addNewAdRequestModel?.addLat ?? ""
        requestModel["lon"] = self.addNewAdRequestModel?.addLng ?? ""
        requestModel["interface_id"] = self.interfaceId
        requestModel["price"] = self.price
        requestModel["room"] = String(self.roomNumbers)
        requestModel["lounges"] = String(self.livingRooms)
        requestModel["bathrooms"] = String(self.bathRooms)
        requestModel["space"] = String(self.streetView)
        requestModel["estate_space"] = self.propertyArea
        requestModel["floor_number"] = String(self.floorNumber)
        requestModel["age_realEstate"] = String(self.propertyAge)
        requestModel["air_conditioners"] = String(Convert.boolValueToIntValue(boolValue: self.airConditioning))
        requestModel["special_surface"] = String(Convert.boolValueToIntValue(boolValue: self.specialSurface))
        requestModel["two_entrances"] = String(Convert.boolValueToIntValue(boolValue: self.twoEntrances))
        requestModel["private_entrance"] = String(Convert.boolValueToIntValue(boolValue: self.privateEntrances))
        requestModel["info"] = self.propertyDetails
        requestModel["furnished"] = String(Convert.boolValueToIntValue(boolValue: self.furnished))
        requestModel["kitchen"] = String(Convert.boolValueToIntValue(boolValue: self.kitchen))
        requestModel["appendix"] = String(Convert.boolValueToIntValue(boolValue: self.annex))
        requestModel["car_entrance"] = String(Convert.boolValueToIntValue(boolValue: self.carEntrance))
        requestModel["elevator"] = String(Convert.boolValueToIntValue(boolValue: self.elevator))
        requestModel["name"] = " "
        requestModel["address"] = self.addNewAdRequestModel?.addAddress ?? ""

        if addNewAdRequestModel?.addStatus == "0" {
            requestModel["rentalperiod_id"] = viewModel.rentalID
            requestModel["resident_id"] = viewModel.residentID
        }
        
        return requestModel
    }
    
}
