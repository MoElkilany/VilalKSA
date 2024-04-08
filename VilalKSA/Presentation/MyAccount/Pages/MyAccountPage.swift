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
    var middleItem: SomeItem?
}

struct MyAccountPage: View {
    
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    @EnvironmentObject var pilotRoot: UIPilot<RootDestination>
    @State var popups = DialogState()
    
    @StateObject var viewModel = MyAccountViewModel()
    
    var body: some View {
        ZStack{
            
            VStack{
                ZStack{
                    Image(R.image.profile_top_background.name)
                        .resizable()
                        .frame(maxWidth: .infinity,maxHeight: 178)
                    
                    TextBold16(textKey: R.string.localizable.user_Profile.localized, textColor: .white)
                }
                
                MyAccountMainInfoView(myAccountData: self.viewModel.myAccountData)
                
                ScrollView(showsIndicators:false){
                    VStack{
                        MyAccountQuickAccessView(items: [
                           
                            IconAndTitleWithActionModel(icon: R.image.profile_myAds.name, text: R.string.localizable.my_Ads.localized,action: {
                                print("my_Ads")
                                pilot.push(.myAdsPage)
                            }),
                            IconAndTitleWithActionModel(icon: R.image.profile_request.name, text: R.string.localizable.my_Requests.localized,action: {
                                print("my_Requests")
                                pilot.push(.myRequestsPage)
//                                popups.middleItem = SomeItem(mainTitle: R.string.localizable.my_Requests.localized, subTitle: nil, image: nil)
                            }),
                            IconAndTitleWithActionModel(icon: R.image.profile_myReservations.name, text: R.string.localizable.my_Reservations.localized,action: {
                                print("my_Reservations")
//                                pilot.push(.myReservationsPage)
                                popups.middleItem = SomeItem(mainTitle: R.string.localizable.my_Reservations.localized, subTitle: nil, image: nil)

                            }),
                            
                            IconAndTitleWithActionModel(icon: R.image.police_Icon.name, text: R.string.localizable.policiesAndProcedures.localized,action: {
                                print("policiesPage")
                                pilot.push(.policiesPage)
                            })
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
                                
//                                IconAndTitleWithActionModel(icon: R.image.profile_Policy.name, text: R.string.localizable.privacy_Policy.localized,action: {
//                                    print("privacy_Policy")
//                                    pilot.push(.privacyPolicy)
//                                }),
                                
                                IconAndTitleWithActionModel(icon: R.image.profile_deleteAccount.name, text: R.string.localizable.delete_Account.localized,action: {
                                    
                                    popups.alertContent = AlertContent(image:  R.image.profile_deleteAccount.name, mainTitle: R.string.localizable.delete_Account.localized, subTitle: R.string.localizable.you_Want_Delete_Account.localized, trueAction: {
                                        print("delete_Account_true")
                                    })
                                }),
                                
                                IconAndTitleWithActionModel(icon: R.image.profile_logOut.name, text: R.string.localizable.log_Out.localized,action: {
                                    print("log_Out")
                                    popups.alertContent = AlertContent(image:  R.image.profile_logOut.name, mainTitle: R.string.localizable.log_Out.localized, subTitle: R.string.localizable.you_Want_logOut.localized, trueAction: {
                                        UserDefaults.standard.set(false, forKey: Constants.isLogin.rawValue)
                                        UserDefaults.standard.setValue(nil, forKey: Constants.beraerToken.rawValue)
                                        UserDefaults.standard.removeObject(forKey:  Constants.beraerToken.rawValue)
                                        UserDefaults.standard.synchronize()
                                       
                           
                                        
                                        if pilotRoot.routes.contains(where: {$0.name == RootDestination.login.name}) {
                                            pilotRoot.popTo(.login)
                                        } else {
                                            pilotRoot.popTo(pilotRoot.routes.first ?? RootDestination.login)
                                            pilotRoot.pop()
                                            pilotRoot.push(.login)
                                        }
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
            if self.viewModel.state == .loading {
                OnScreenLoading
            }
        }
        .task {
            self.viewModel.getProfileData()
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
        
        .ignoresSafeArea(.all)
        .padding(.bottom,30)
    }
}

#Preview {
    MyAccountPage()
}
