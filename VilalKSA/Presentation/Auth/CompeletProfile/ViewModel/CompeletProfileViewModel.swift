//
//  CompeletProfileViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 09/01/2024.
//

import Moya
import SwiftUI
class CompeletProfileViewModel: ObservableObject {
    
    @Published var state: AppState = .success
    @Published var errorPopUp: Bool = false
    @Published var errorMessage: LocalizedStringKey = ""
    @Published var isLogin = false
    @Published var successBottomSheet: Bool = false
    @Published var successTitle: String = ""
    
    var isVaildFirstName       = false
    var isVaildSecondName      = false
    var isVaildEmailName       = false
    var isVaildPassword        = false
    var isVaildRewritePassword = false
    
    private let apiService = AuthAPIClient()
    var error: MoyaError?
    
    func compeletProfile(request: CompleteProfileModelRequest) {
        
        self.state = .loading
        apiService.compeletProfile(request: request) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let value):
                self.handleSuccess(value)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    private func handleSuccess(_ value: LoginResponse?) {
        state = .success
        guard let response = value?.data else { return }
        
        if response.isverified == true && response.isfinished == true {
            successTitle = value?.message ?? ""
            successBottomSheet = true
            DispatchQueue.main.async {
                self.isLogin = true
            }
        } else {
            errorMessage = LocalizedStringKey(value?.message ?? "")
            errorPopUp = true
        }
    }
    
    private func handleError(_ error: APIError) {
        state = .error
        
        switch error {
        case .errorMessage(let message, _):
            print("Error Message: \(message)")
            errorPopUp = true
            errorMessage = LocalizedStringKey(message)
        default:
            print("An unknown error occurred.")
            errorPopUp = true
            errorMessage = (R.string.localizable.unknown_Error_Occurred.localized)
        }
    }
    
    func isValidForm() -> Bool {
        return isVaildFirstName &&
        isVaildSecondName  &&
        isVaildEmailName  &&
        isVaildPassword  &&
        isVaildRewritePassword
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    func validateFields(firstName: String, secondName: String, email: String, password: String, rewritePassword: String) -> Bool {
        if  rewritePassword.isEmpty || rewritePassword != password {
            errorMessage = (R.string.localizable.passwords_Do_Not_Match.localized)
        } else {
            return true
        }
        
        errorPopUp = true
        return false
    }
    
    
}


