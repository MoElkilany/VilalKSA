//
//  MyAccountPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI
import UIPilot
import PopupView

struct DialogState {
    var alertContent: AlertContent?
}

struct MyAccountPage: View {
    
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    @State var popups = DialogState()
    
    var body: some View {
        VStack{
            ZStack{

                Image(R.image.profile_top_background.name)
                    .resizable()
                    .frame(maxWidth: .infinity,maxHeight: 178)
                
                TextBold16(textKey: R.string.localizable.user_Profile.localized, textColor: .white)
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
                            pilot.push(.myAdsPage)
                        }),
                        IconAndTitleWithActionModel(icon: R.image.profile_request.name, text: R.string.localizable.my_Requests.localized,action: {
                            print("my_Requests")
                            pilot.push(.myRequestsPage)
                        }),
                        IconAndTitleWithActionModel(icon: R.image.profile_myReservations.name, text: R.string.localizable.my_Reservations.localized,action: {
                            print("my_Reservations")
                            pilot.push(.myReservationsPage)
                        }),
                    ])
                    
                    
                    VStack{
                        MyAccountOptionsMenuView(items: [
                            IconAndTitleWithActionModel(icon: R.image.profile_aboutApp.name, text: R.string.localizable.about_the_App.localized,action: {
                                pilot.push(.aboutAppPage)
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_lang.name, text: R.string.localizable.language.localized,action: {
                                pilot.push(.languagePage)
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_customerServices.name, text: R.string.localizable.customer_Service.localized,action: {
                                pilot.push(.contactUsPage)
                                print("customer_Service")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_cancelsReason.name, text: R.string.localizable.cancellation_Terms.localized,action: {
                                pilot.push(.cancellationTerms)
                                print("cancellation_Terms")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_condition.name, text: R.string.localizable.terms_and_Conditions.localized,action: {
                                pilot.push(.termsAndConditions)
                                print("terms_and_Conditions")
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_Policy.name, text: R.string.localizable.privacy_Policy.localized,action: {
                                print("privacy_Policy")
                                pilot.push(.privacyPolicy)
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_deleteAccount.name, text: R.string.localizable.delete_Account.localized,action: {
                               
                                popups.alertContent = AlertContent(image:  R.image.profile_deleteAccount.name, mainTitle: R.string.localizable.delete_Account.localized, subTitle: R.string.localizable.you_Want_Delete_Account.localized, trueAction: {
                                    print("delete_Account_true")
                                })
                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.profile_logOut.name, text: R.string.localizable.log_Out.localized,action: {
                                print("log_Out")
                                popups.alertContent = AlertContent(image:  R.image.profile_logOut.name, mainTitle: R.string.localizable.log_Out.localized, subTitle: R.string.localizable.you_Want_logOut.localized, trueAction: {
                                    print("log_Out_true")
                                })
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
        .popup(item: $popups.alertContent) { item in
            AlertDialog(item: item) {
                popups.alertContent = nil
            }
        } customize: {
            $0
                .position(.center)
                .animation(.bouncy())
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
        }
        .ignoresSafeArea(.all)
        .padding(.bottom,30)
    }
}

#Preview {
    MyAccountPage()
}
