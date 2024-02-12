//
//  AddNewAdLocationPage.swift
//  VilalKSA
//
//  Created by Elkilany on 11/02/2024.
//

import SwiftUI
import UIPilot
import LanguageManagerSwiftUI

struct AddNewAdLocationPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @StateObject var viewModel = AddNewAdCategoryViewModel()
    var addNewAdRequestModel:AddNewAdRequestModel?

    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.property_Location.localized, tryAgainAction: {
        },backAction:{
            pilot.pop()
        } ,content: {
            ScrollView{
                VStack{
                    StepsBarView(stepNumber: "1", stepImage: R.image.step1_AddNewAds.name)
                    Image(R.image.map_Placeholder.name)
                        .resizable()
                        .frame(maxWidth: .infinity,maxHeight: 400)
                        .padding()
                    DefaultButton(title:  R.string.localizable.next.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        pilot.push(.propertyGalleryPage(model: AddNewAdRequestModel(categoryAdID: addNewAdRequestModel?.categoryAdID ?? "", addLat: "31.233231111222", addLng: "31.233231111222", addAddress: "Cairo Egypt")))
                    }, fontWeight: .bold)
                    Spacer()
                    
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top,20)
                .onAppear(perform: {
                    print("the category id is ", addNewAdRequestModel?.categoryAdID ?? "")
                })
            }
            
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
            TextMeduim12(text: R.string.localizable.step.localized, textColor: R.color.color172B4D.name.getColor())
            HStack(spacing:0){
                if  languageSettings.selectedLanguage == .ar {
                    TextBold14(text: "/3"  , textColor: R.color.color172B4D.name.getColor())
                    TextBold14(text: LocalizedStringKey(stepNumber) , textColor: R.color.color172B4D.name.getColor())
                }else{
                    TextBold14(text: LocalizedStringKey(stepNumber) , textColor: R.color.color172B4D.name.getColor())
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
        .padding(.horizontal, 15)
        
    }
}

