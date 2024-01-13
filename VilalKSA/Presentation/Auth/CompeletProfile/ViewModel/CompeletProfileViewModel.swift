//
//  CompeletProfileViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 09/01/2024.
//

import Moya

class CompeletProfileViewModel: ObservableObject {
    
    @Published var state: AppState = .success
    @Published var errorPopUp: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLogin = false
    @Published var successBottomSheet: Bool = false
    @Published var successTitle: String = ""
    
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
             errorMessage = value?.message ?? ""
               errorPopUp = true
            }
        }
        
        private func handleError(_ error: APIError) {
            state = .error
            
            switch error {
            case .errorMessage(let message, _):
                print("Error Message: \(message)")
                errorPopUp = true
                errorMessage = message
            default:
                print("An unknown error occurred.")
                errorPopUp = true
                errorMessage = "An unknown error occurred."
            }
        }
    
    private func isValidEmail(_ email: String) -> Bool {
         let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
         let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
         return emailPredicate.evaluate(with: email)
     }
    
     func validateFields(firstName: String, secondName: String, email: String, password: String, rewritePassword: String) -> Bool {
         if firstName.isEmpty {
             errorMessage = "Please Enter the first Name"
         } else if secondName.isEmpty {
             errorMessage = "Please Enter the second Name"
         } else if email.isEmpty || !isValidEmail(email) {
             errorMessage = "Please Enter a valid email"
         } else if password.isEmpty || password.count < 8 {
             errorMessage = "Please Enter a password with at least 6 characters"
         } else if rewritePassword.isEmpty || rewritePassword != password {
             errorMessage = "Passwords do not match"
         } else {
             return true
         }
         
         errorPopUp = true
         return false
     }
    
    
}


