//
//  CreateAcountViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 06/01/2024.
//

import Moya
import SwiftUI

class CreateAcountViewModel: ObservableObject {
    
    @Published var state: AppState = .success
    @Published var errorPopUp: Bool = false
    @Published var errorMessage: LocalizedStringKey = R.string.localizable.error_Phone_Required.localized
    @Published var isNotVerified: Bool = false
    
    private let apiService = AuthAPIClient()
    var error: MoyaError?
    
    func registerPhone(request: RegisterPhoneRequest) {
        
        self.state = .loading
        apiService.registerPhone(request: request) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let value):
                self.state = .success
                guard let response = value?.data else { return }
                if  response.isverified == true && response.isfinished == false {
                    isNotVerified = true
                }else  if response.isverified == true && response.isfinished == true  {
                    errorMessage =  R.string.localizable.certainly_Registered_Please_Login.localized
                    errorPopUp = true
                }else{
                    if  response.isverified == false && response.isfinished == false {
                        isNotVerified = true
                    }
                }
  
            case .failure(let error):
                self.state = .error
                
                switch error {
                case .errorMessage(let message, _):
                    print("Error Message: \(message)")
                    self.errorPopUp = true
                    self.errorMessage = LocalizedStringKey(message)
                default:
                    print("An unknown error occurred.")
                    self.errorPopUp = true
                    self.errorMessage = (R.string.localizable.unknown_Error_Occurred.localized)
                }
            }
        }
    }
}


