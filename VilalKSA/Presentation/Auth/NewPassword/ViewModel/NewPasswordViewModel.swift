//
//  NewPasswordViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 11/01/2024.
//


import Moya
import SwiftUI

class NewPasswordViewModel: ObservableObject {
    
    // MARK: - Published Properties

    @Published var state: AppState = .success
    @Published var errorPopUp: Bool = false
    @Published var errorMessage: LocalizedStringKey = (R.string.localizable.password_Required.localized)
    @Published var isSuccess: Bool = false
    
    // MARK: - Private Properties
    
    private let apiService: AuthAPIClient
    private var cancellable: Cancellable?
    
    var isVaildPassword        = false
    var isVaildRewritePassword = false
    
    // MARK: - Initialization
    
    init(apiService: AuthAPIClient = AuthAPIClient()) {
        self.apiService = apiService
    }
    
    // MARK: - Public Methods
    
    func changePassword(request: ChangePasswordRequest) {
        self.state = .loading
        self.cancelRequest()

        self.cancellable = apiService.changePassword(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleSuccess(value)
            case .failure(let error):
                self.handleError(error)
            }
        } as? any Cancellable
    }
    
    func validatePasswords(_ password: String,_ confirmPassword: String) -> Bool {
           if password.isEmpty {
               errorMessage = (R.string.localizable.password_Required.localized)
               errorPopUp = true
               return false
           }
           
        if confirmPassword.isEmpty {
            errorMessage = (R.string.localizable.confirm_Password_Required.localized)
            errorPopUp = true
            return false
        }
        
        if password != confirmPassword {
            errorMessage = (R.string.localizable.passwords_Do_Not_Match.localized)
            errorPopUp = true
            return false
        }
        
           return true
       }
    
  
    
    // MARK: - Private Methods
    
    private func handleSuccess(_ value: LoginResponse?) {
        self.state = .success
        guard let status = value?.status else { return }
        
        if status == 200 {
            self.isSuccess = true
        } else {
            self.errorMessage = LocalizedStringKey(value?.message ?? "")
            self.showErrorPopup()
        }
    }
    
    private func handleError(_ error: APIError) {
        self.state = .error
        
        switch error {
        case .errorMessage(let message, _):
            self.errorMessage = LocalizedStringKey(message)
        default:
            self.errorMessage = (R.string.localizable.unknown_Error_Occurred.localized)
        }
        
        self.showErrorPopup()
    }
    
    private func showErrorPopup() {
        self.errorPopUp = true
    }
    
    private func cancelRequest() {
        self.cancellable?.cancel()
        self.cancellable = nil
    }
    
    func isValidForm() -> Bool {
        isVaildPassword  &&
        isVaildRewritePassword
        
    }
}
