//
//  AddRequestPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI
import PopupView
import UIPilot

struct AdsDialog {
    var addNewAdsDialog = false
}

struct AddRequestPage: View {

    @State var popUps = AdsDialog()
    @StateObject var tabBarSelection = TabBarSelection()

    var body: some View {
        VStack{
            Button(action: {
                popUps.addNewAdsDialog = true
            }, label: {
                Image(R.image.home_Placeholder.name)
                    .resizable()
            })
        }
        .ignoresSafeArea(.all)
        .onAppear(perform: {
            popUps.addNewAdsDialog = true
        })
        .popup(isPresented: $popUps.addNewAdsDialog) {
            AddNewAdsDialog()
        } customize: {
            $0
                .type(.floater(verticalPadding: 50, useSafeAreaInset: false))
                .animation(.spring())
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(false)
                .backgroundColor(.black.opacity(0.4))
                .dismissCallback {
                    tabBarSelection.selectedTab = .TabBarMain
                }
        }
        
    }
}
