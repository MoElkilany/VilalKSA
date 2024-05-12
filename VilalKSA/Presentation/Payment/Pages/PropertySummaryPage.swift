//
//  PropertySummaryPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/03/2024.
//

import SwiftUI
import UIPilot

struct PropertySummaryPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    @State private var showActionSheet = false

    @State var state: AppState = .success
    var model: SummaryModel?
    var navigationType: AdDetailsTypes
  
    
    var body: some View {

        VilalKSAContainer(state: self.$state,titlePage: R.string.localizable.property_Summary.localized, tryAgainAction: {
            
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
                
                VStack{
                    PropertyContainerView(imageUrl: model?.imageUrl ?? "" , rate: "", category: model?.category ?? "", name: model?.name ?? "" , room: model?.room ?? "" , space: model?.space ?? "" , price: model?.price ?? "",favourite: model?.favourite ?? false , location: model?.location, rental: model?.rental ?? "", addOrRemoveFavouriteAction: nil )
                    VStack{
                    HStack{
                        TextBold14(textKey:R.string.localizable.amount.localized , textColor: R.color.color7A869A.name.getColor())
                        Spacer()
                        TextBold14(text:model?.price ?? "", textColor: R.color.color42526E.name.getColor())
                        TextBold14(textKey:R.string.localizable.thousand.localized , textColor: R.color.color42526E.name.getColor())
                    }
                    .padding(.horizontal,15)
                    
                    HStack{
                        TextBold14(textKey:R.string.localizable.tax.localized , textColor: R.color.color7A869A.name.getColor())
                        Spacer()
                        TextBold14(text:"0 %", textColor: R.color.color42526E.name.getColor())
                    }
                    .padding(.horizontal,15)
                        Spacer()
                        .frame(height: 50)
                    
                    HStack{
                        TextBold14(textKey:R.string.localizable.total.localized , textColor: R.color.color7A869A.name.getColor())
                        Spacer()
                        let price = (Int(model?.price ?? "") ?? 0)
//                        let totalPrice = Double(price) * (5.0 / 100.0)
                        TextBold14(text:  model?.price ?? "" , textColor: R.color.color42526E.name.getColor())
                        TextBold14(textKey:R.string.localizable.thousand.localized , textColor: R.color.color42526E.name.getColor())
                    }
                    .padding(.horizontal,15)
                }
                .padding(.horizontal,15)
                    VilalDivider()
//                    DefaultBoarderButtonWithIcon(title:model?.type == "0" ? R.string.localizable.complete_Booking_Process.localized : R.string.localizable.complete_Purchase_Process.localized ,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                    DefaultBoarderButtonWithIcon(title: R.string.localizable.contact_Advertiser.localized ,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                        self.showActionSheet = true
//                        switch navigationType {
//                        case .ads:
//                            pilot.push(.paymentMethodsPage(type: self.navigationType))
//                        case .main:
//                            mainPilot.push(.paymentMethodsPage(type: self.navigationType))
//                        case .toDaysAds:
//                            servicesPilot.push(.paymentMethodsPage(type: self.navigationType))
//                        case .favorite:
//                            favoritePilot.push(.paymentMethodsPage(type: self.navigationType))
//                        }
                        
                       
                    })
                    .frame(height: 50)
                    .padding(.horizontal,50)
                }
            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        .actionSheet(isPresented: $showActionSheet) {
            getActionSheet()
        }
    }
    
        
    private func getActionSheet() -> ActionSheet {

        return ActionSheet(
            title: Text(R.string.localizable.contact_Advertiser.localized),
            message: nil,
            buttons: [
                .default(Text(R.string.localizable.whatsApp.localized)) {
                    VilalHelper.openWhatsApp(urlString:self.model?.whatsApp ?? "" )
                    showActionSheet = false
                },
                .default(Text(R.string.localizable.call.localized)) {
                    VilalHelper.makePhoneCall(phoneNumber:self.model?.phoneNumber ?? "" )
                    showActionSheet = false
                },
                .cancel()
            ]
        )
    }
    
    
    
}

