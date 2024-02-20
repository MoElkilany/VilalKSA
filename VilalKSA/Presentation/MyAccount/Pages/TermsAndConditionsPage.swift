//
//  TermsAndConditionsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 09/02/2024.
//


import SwiftUI
import UIPilot

struct TermsAndConditionsPage: View {
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    @State var state: AppState = .success
    
    var body: some View {

        VilalKSAContainer(state: $state,titlePage: R.string.localizable.terms_and_Conditions.localized, tryAgainAction: nil,backAction:{
            pilot.pop()
        },content: {
            VStack {
            
                Image(R.image.options_Logo.name)
                    .resizable()
                    .frame(height: 200)
        
                TextBold16(textKey: R.string.localizable.about_App_Des.localized, textColor: R.color.color7A869A.name.getColor())
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color.white)
                        .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                
            }
       
        })
        .ignoresSafeArea(.all)
        .padding(.bottom,50)
    }
}

