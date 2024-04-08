//
//  AddNewAdLocationPage.swift
//  VilalKSA
//
//  Created by Elkilany on 11/02/2024.
//

import SwiftUI
import UIPilot
import LanguageManagerSwiftUI
import CoreLocation

struct AddNewAdLocationPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @StateObject var viewModel = AddNewAdCategoryViewModel()
    var addNewAdRequestModel:AddNewAdRequestModel?
    
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var selectedAddress: String?
    @State private var isPressed: Bool = false

    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.property_Location.localized, tryAgainAction: {
        },backAction:{
            pilot.pop()
        } ,content: {
                VStack{
                    StepsBarView(stepNumber: "1", stepImage: R.image.step1_AddNewAds.name)
                    
                    ZStack{
                        VStack{
                            
                        }
                        .frame(height: 350)
                        .customCardStyle()
                        .padding(.bottom,100)
                        
                        VStack{
                            GeometryReader { geometry in
                                VStack(alignment: .leading,spacing: 0) {
                                    HStack{
                                        TextBold14(textKey: R.string.localizable.customer_Details_Location.localized, textColor: R.color.colorPrimary.name.getColor())
                                        Spacer()
                                    }
                                    SelectedLocationGoogleMapsView(locationManager: locationManager, didSelectLocation: { location, address in
                                        selectedLocation = location
                                        selectedAddress = address
                                    })
                                    .frame(width: geometry.size.width, height: 300)
                                    .padding(4)
                                    .cornerRadius(50)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    if isPressed == true {
                        if selectedLocation == nil {
                            HStack{
                                ErrorTextView(errorText: R.string.localizable.please_Select_Property_Location.localized)
                                Spacer()
                            }
                        }
                    }
                    
                    DefaultButton(title:  R.string.localizable.next.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        self.isPressed = true
                        if selectedLocation != nil {
                            pilot.push(.propertyGalleryPage(model: AddNewAdRequestModel(categoryAdID: addNewAdRequestModel?.categoryAdID ?? "", addLat: String(selectedLocation?.latitude ?? 21.111), addLng: String(selectedLocation?.longitude ?? 21.111), addAddress: self.selectedAddress,addStatus: addNewAdRequestModel?.addStatus ?? "")))
                        }
                    }, fontWeight: .bold)
                    Spacer()
                    
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top,20)
                .onAppear(perform: {
                    print("the category id is ", addNewAdRequestModel?.categoryAdID ?? "")
                    
                })
            
        })
        
       
        
    }
}

#Preview {
    AddNewAdLocationPage()
}





struct StepsBarView: View {
    let stepNumber:String
    let stepImage:String
    @EnvironmentObject var languageSettings: LanguageSettings

    var body: some View {
        HStack(spacing:10){
            TextMeduim12(textKey: R.string.localizable.step.localized, textColor: R.color.color172B4D.name.getColor())
            HStack(spacing:0){
                if  languageSettings.selectedLanguage == .ar {
                    TextBold14(text: "/3"  , textColor: R.color.color172B4D.name.getColor())
                    TextBold14(text: (stepNumber) , textColor: R.color.color172B4D.name.getColor())
                }else{
                    TextBold14(text: (stepNumber) , textColor: R.color.color172B4D.name.getColor())
                    TextBold14(text:  "/3" , textColor: R.color.color172B4D.name.getColor())
                }
               
            }
            Image(stepImage)
            Spacer()
        }
        .padding(12)
        .frame(maxWidth: .infinity,maxHeight: 40)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
        .padding(.horizontal, 10)
        
    }
}

