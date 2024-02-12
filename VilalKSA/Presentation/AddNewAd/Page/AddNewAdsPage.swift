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
    @StateObject var viewModel = AddNewAdCategoryViewModel()
    var addNewAdRequestModel:AddNewAdRequestModel?

    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.property_Images.localized, tryAgainAction: {
        },backAction:{
            pilot.pop()
        } ,content: {
            ScrollView{
                VStack{
                    StepsBarView(stepNumber: "3", stepImage: R.image.step3_AddNewAds.name)
                        .padding(.bottom,50)
                    
                    PropertyInterfaceView()
                    DefaultButton(title:  R.string.localizable.add.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                    }, fontWeight: .bold)
                    
                    
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top,20)
                .onAppear(perform: {
                    print("the AddNewAdsPage model is , ", addNewAdRequestModel)
                })
                            
            }
        })
    }
}
