//
//  MyAccountPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI
import UIPilot

struct MyAccountPage: View {
    
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    
    var body: some View {
        VStack{
            ZStack{
                
                Image(R.image.profile_top_background.name)
                    .resizable()
                    .frame(width: .infinity, height: 178, alignment: .center)
                
                TextBold16(text: R.string.localizable.user_Profile.localized, textColor: .white)
            }
            
            MyAccountMainInfoView()
            
            ScrollView(showsIndicators:false){
                VStack{
                    MyAccountQuickAccessView(items: [
                        IconAndTitleWithActionModel(icon: R.image.profile_fav.name, text: R.string.localizable.favorites.localized,action: {
                            print("favorites")
                            pilot.push(.favorites)
                        }),
                        IconAndTitleWithActionModel(icon: R.image.profile_myAds.name, text: R.string.localizable.my_Ads.localized,action: {
                            print("my_Ads")
                        }),
                        IconAndTitleWithActionModel(icon: R.image.profile_request.name, text: R.string.localizable.my_Requests.localized,action: {
                            print("my_Requests")
                        }),
                        IconAndTitleWithActionModel(icon: R.image.profile_myReservations.name, text: R.string.localizable.my_Reservations.localized,action: {
                            print("my_Reservations")
                        }),
                    ])
                    
                    
                    VStack{
                        MyAccountOptionsMenuView(items: [
                            IconAndTitleWithActionModel(icon: R.image.profile_aboutApp.name, text: R.string.localizable.about_the_App.localized,action: {
                                print("about_the_App")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_lang.name, text: R.string.localizable.language.localized,action: {
                                print("language")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_customerServices.name, text: R.string.localizable.customer_Service.localized,action: {
                                print("customer_Service")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_cancelsReason.name, text: R.string.localizable.cancellation_Terms.localized,action: {
                                print("cancellation_Terms")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_condition.name, text: R.string.localizable.terms_and_Conditions.localized,action: {
                                print("terms_and_Conditions")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_Policy.name, text: R.string.localizable.privacy_Policy.localized,action: {
                                print("privacy_Policy")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_deleteAccount.name, text: R.string.localizable.delete_Account.localized,action: {
                                print("delete_Account")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_logOut.name, text: R.string.localizable.log_Out.localized,action: {
                                print("log_Out")
                            }),
                        ])
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                    .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
                .padding(.horizontal, 20)
            }
            
            
            
            Spacer()
            
        }
        .ignoresSafeArea(.all)
        .padding(.bottom,30)
    }
}

#Preview {
    MyAccountPage()
}
