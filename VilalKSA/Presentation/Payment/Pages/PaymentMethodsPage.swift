//
//  PaymentMethodsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 14/03/2024.
//

import SwiftUI
import UIPilot

struct PaymentMethodsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    @State var popups = DialogState()
    @State var state: AppState = .success
    var navigationType: AdDetailsTypes

    var body: some View {
        VilalKSAContainer(state: self.$state,titlePage: R.string.localizable.payment_Method.localized, tryAgainAction: {
            
        },backAction:{
            switch navigationType {
            case .ads:
                pilot.pop()
            case .main:
                mainPilot.pop()
            case .toDaysAds:
                servicesPilot.pop()
            case .favorite:
                favoritePilot.pop()
            }
        } ,content: {
            ScrollView(showsIndicators:false){
                VStack(alignment: .leading){
                    TextBold14(textKey: R.string.localizable.credit_and_Debit_Cards.localized, textColor: R.color.color172B4D.name.getColor())
                    Button {
                        switch navigationType {
                        case .ads:
                            pilot.push(.myPersonalCardsPage(type: self.navigationType))
                        case .main:
                            mainPilot.push(.myPersonalCardsPage(type: self.navigationType))
                        case .toDaysAds:
                            servicesPilot.push(.myPersonalCardsPage(type: self.navigationType))
                        case .favorite:
                            favoritePilot.push(.myPersonalCardsPage(type: self.navigationType))
                        }
                         
                    } label: {
                        PaymentMethodsView(icon: R.image.myCards.name, value: R.string.localizable.my_Cards.localized)
                    }
                    VilalDivider()
                    TextBold14(textKey: R.string.localizable.more_Payment_Options.localized, textColor: R.color.color172B4D.name.getColor())
                    
                    PaymentMethodsView(icon: R.image.paypalIcon.name, value: R.string.localizable.payPal.localized)
                        .onTapGesture {
                            popups.middleItem = SomeItem(mainTitle: R.string.localizable.payPal.localized, subTitle: nil, image: nil)
                        }
                
                    PaymentMethodsView(icon: R.image.applePayIcon.name, value: R.string.localizable.apple_Pay.localized)
                        .onTapGesture {
                            popups.middleItem = SomeItem(mainTitle: R.string.localizable.apple_Pay.localized, subTitle: nil, image: nil)
                        }
            
                    VilalDivider()
                    
                }
                .padding()
            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        
        .popup(item: $popups.middleItem) { item in
            PopupMiddle(item: item) {
                popups.middleItem = nil
            }
        } customize: {
            $0
                .closeOnTapOutside(true)
                .closeOnTap(true)
                .backgroundColor(.black.opacity(0.3))
        }
    }
}




struct PaymentMethodsView: View {
    var icon:String?
    var value:LocalizedStringKey?
    
    var body: some View {
        
        HStack(spacing:2) {
            Image(icon ?? R.image.bed_icon.name)
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
            TextBold14(textKey: value ?? "0", textColor: R.color.color172B4D.name.getColor())
            Spacer()
            Image(R.image.circleIcon.name)
                .resizable()
                .frame(width: 15, height: 15, alignment: .center)
            
        }
    }
}
