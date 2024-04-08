//
//  RentalReservationPage.swift
//  VilalKSA
//
//  Created by Elkilany on 28/03/2024.
//

import SwiftUI
import UIPilot

struct RentalReservationPage: View {
    
    var rentalReservationModel: RentalReservationModel
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    var navigationType: AdDetailsTypes = .ads
    
    @State var appState: AppState = .success
    @State var showTermsAndCondition: Bool = false

    var body: some View {
        
        VilalKSAContainer(state: $appState,titlePage: R.string.localizable.reservation.localized, tryAgainAction:nil , backAction: {
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
        }, content: {
            
            VStack{
                
                VStack{
                    RentalReservationKeyValueBarView(key: R.string.localizable.check_in.localized, value: rentalReservationModel.checkIn)
                    VilalDivider()
                    RentalReservationKeyValueBarView(key: R.string.localizable.check_out.localized, value: rentalReservationModel.checkOut)
                    VilalDivider()
                    RentalReservationKeyValueBarView(key: R.string.localizable.number_OF_Nights.localized, value: rentalReservationModel.numberOfNight)
                    VilalDivider()
                    RentalReservationKeyValueBarView(key: R.string.localizable.total_Price.localized, value: rentalReservationModel.totalPrice)
                }
                
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(RoundedRectangle(cornerRadius: 10.0)
                    .fill(R.color.colorF1F5F9.name.getColor()))
                .padding()
                
                HStack{
                    TextRegular14(textKey:R.string.localizable.i_Agree_To.localized,textColor: R.color.color7A869A.name.getColor())
                    Button(action: {
                        showTermsAndCondition = true
                    }, label: {
                        TextRegular14(textKey:R.string.localizable.terms_conditions.localized,textColor: R.color.colorPrimary.name.getColor())
                    })
                    TextRegular14(textKey:R.string.localizable.instant_rental_service.localized,textColor: R.color.color7A869A.name.getColor())
                }
                .padding(.horizontal,10)
                
                DefaultBoarderButtonWithIcon(title:R.string.localizable.next.localized  ,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                    switch navigationType {
                    case .ads:
                        pilot.push(.paymentMethodsPage(type: self.navigationType))
                    case .main:
                        mainPilot.push(.paymentMethodsPage(type: self.navigationType))
                    case .toDaysAds:
                        servicesPilot.push(.paymentMethodsPage(type: self.navigationType))
                    case .favorite:
                        favoritePilot.push(.paymentMethodsPage(type: self.navigationType))
                    }
                })
                .frame(width: 200, height: 50)
                
                .sheet(isPresented: $showTermsAndCondition) {
                    ScrollView{
                        TextRegular16(text:"Test",textColor: R.color.colorPrimary.name.getColor())
                            .padding(25)
                    }
                }
            }
        })
    }
}



struct RentalReservationKeyValueBarView: View {
    let key: LocalizedStringKey?
    let value: String?
    let valueColor: Color? = R.color.color42526E.name.getColor()
    
    var body: some View{
        VStack(spacing:5){
            HStack{
                TextBold12(textKey:key ?? "", textColor: R.color.color172B4D.name.getColor())
                Spacer()
                TextRegular14(text: value ?? "", textColor: valueColor ?? R.color.color42526E.name.getColor() )
            }
        }
    }
}

struct RentalReservationModel: BaseModel {
    var checkIn: String
    var checkOut: String
    var numberOfNight: String
    var totalPrice: String
    
}
