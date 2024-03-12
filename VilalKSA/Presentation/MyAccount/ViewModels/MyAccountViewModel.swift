//
//  MyAccountViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import Moya
import SwiftUI

class MyAccountViewModel: BaseViewModel {
    
    private let apiService: MyAccountAPIClient
    @Published var myAccountData: MyAccountModel? = nil
    private var hasFetchedData = false
    
    init(apiService: MyAccountAPIClient = MyAccountAPIClient()) {
        self.apiService = apiService
    }
    
    func getProfileData() {
        guard !hasFetchedData else {
            return
        }
        
        self.state = .loading
        apiService.getProfileData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleSuccess(value)
                self.hasFetchedData = true
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
    
    
    override func handleSuccess<T>(_ value: T) {
        if let response = value as? MyAccountResponseModel {
            guard let status = response.status else { return }
            if status == 200 {
                if let responseData = response.data {
                    self.state = .success
                    self.myAccountData = responseData
                }else{
                    self.state = .noData
                }
                
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
    
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
