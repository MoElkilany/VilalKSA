//
//  MyAccountViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import Moya
import SwiftUI

class MyAccountViewModel: BaseViewModel {

    
    
    func getMyAccountQuickAccessData()-> [IconAndTitleWithActionModel] {
      return [
        IconAndTitleWithActionModel(icon: R.image.profile_fav.name, text: R.string.localizable.favorites.localized,action: {
            print("favorites")
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
    ]
    }
    
    
    func getMyAccountOptionsMenuData()-> [IconAndTitleWithActionModel] {
      return [
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
    ]
    }
    
    
}
