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
    @State private var propertyArea: Int = 1
    
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
    
    @State private var price: String = ""
    @State private var propertyDetails: String = ""
    @State private var interfaceId: String = ""
    @State private var propertyName: String = ""
    
    @State private var submitButton = false
    
    @State private var state: AppState = .success
    
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
                            TextBold14(textKey: R.string.localizable.price.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                            
                            VilalTextField(text: $price, placeholder:  R.string.localizable.price.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                self.viewModel.isPriceValid = isValid
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
                        SliderView(sliderValue: $propertyArea, localizedTitle:  R.string.localizable.property_Area.localized, localizedKey: R.string.localizable.one_Thousand_Meters.localized,valueFrom: 1,valueTo: 50)
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
                        SwitchButtonView(localizedTitle:  R.string.localizable.villa.localized, switchValue: $villa)
                        VilalDivider()
                        SwitchButtonView(localizedTitle:  R.string.localizable.two_Entries.localized, switchValue: $twoEntrances)
                        VilalDivider()
                        SwitchButtonView(localizedTitle:  R.string.localizable.private_Entry.localized, switchValue: $privateEntrances)
                            .padding(.bottom,8)
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
                            let requestModel : [String:String] = [
                                "type_id":"2",
                                "category_id":self.addNewAdRequestModel?.categoryAdID ?? "",
                                "lat":self.addNewAdRequestModel?.addLat ?? "",
                                "lon":self.addNewAdRequestModel?.addLng ?? "",
                                "interface_id":self.interfaceId,
                                "price":self.price,
                                "room":String(self.roomNumbers),
                                "lounges":String(self.livingRooms),
                                "bathrooms":String(self.bathRooms),
                                "space":String(self.streetView),
                                "estate_space":String(self.propertyArea),
                                "floor_number":String(self.floorNumber),
                                "age_realEstate":String(self.propertyAge),
                                "air_conditioners":String(Convert.boolValueToIntValue(boolValue: self.airConditioning)),
                                "special_surface":String(Convert.boolValueToIntValue(boolValue: self.specialSurface)),
                                "villa":String(Convert.boolValueToIntValue(boolValue: self.villa)),
                                "two_entrances":String(Convert.boolValueToIntValue(boolValue: self.twoEntrances)),
                                "private_entrance":String(Convert.boolValueToIntValue(boolValue: self.privateEntrances)),
                                "info":self.propertyDetails,
                                "furnished":String(Convert.boolValueToIntValue(boolValue: self.furnished)),
                                "kitchen":String(Convert.boolValueToIntValue(boolValue: self.kitchen)),
                                "appendix": String(Convert.boolValueToIntValue(boolValue: self.annex)),
                                "car_entrance":String(Convert.boolValueToIntValue(boolValue: self.carEntrance)),
                                "elevator":String(Convert.boolValueToIntValue(boolValue: self.elevator)),
                                "name":self.propertyName,
                                "address":self.addNewAdRequestModel?.addAddress ?? "",
                            ]
                            
                            self.viewModel.createNewAds(video: self.addNewAdRequestModel?.videosData ?? Data(), images: addNewAdRequestModel?.images ?? [] , model: requestModel)
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
            .task {
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
            
        })
    }
    
}
