//
//  VerificationCodeViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 09/01/2024.
//

import Moya
import SwiftUI

class VerificationCodeViewModel: ObservableObject {
    
    @Published var state: AppState = .success
    @Published var errorPopUp: Bool = false
    @Published var errorMessage: LocalizedStringKey = R.string.localizable.invalid_Code.localized
    @Published var userStatus: UserStatus = .none
    @Published var successBottomSheet: Bool = false
    @Published var successTitle: String = ""
    
    private let apiService = AuthAPIClient()
    var error: MoyaError?
    
    func verificationCode(request: VerificationCodeRequest) {
        self.state = .loading
        apiService.verificationCode(request: request) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let value):
                self.state = .success
                guard let response = value?.data else { return }
                
                if  response.isverified == true {
                    if let token = response.token {
                        UserDefaults.standard.set(token, forKey: Constants.beraerToken.rawValue)
                        UserDefaults.standard.synchronize()
                    }
                    userStatus = .isNotCompeletProfile
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
    
    func codeForgetPassword(request: CodeForgetPasswordRequest) {
        self.state = .loading
        apiService.codeForgetPassword(request: request) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let value):
                self.state = .success
                guard let response = value?.data else { return }
                
                if  response.isverified == true {
                    if let token = response.token {
                        UserDefaults.standard.set(token, forKey: Constants.beraerToken.rawValue)
                        UserDefaults.standard.synchronize()
                    }
                    userStatus = .isNotCompeletProfile
                }else{
                    self.errorMessage = (R.string.localizable.profile_Not_Complete.localized)
                    self.errorPopUp = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.userStatus = .isNotVerified
                    })
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
    
    
    func resendCode(request: ResendCodeRequest) {
        self.state = .loading
        apiService.resendCode(request: request) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let value):
                self.state = .success
                guard let status = value?.status else { return }
                if status == 200 {
                    successTitle = value?.message ?? ""
                    successBottomSheet = true
                }else{
                    self.errorMessage = LocalizedStringKey(value?.message ?? "")
                    self.errorPopUp = true
                  
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
