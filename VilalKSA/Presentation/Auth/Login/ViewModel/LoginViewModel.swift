//
//  LoginViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 05/01/2024.
//

import Foundation
import Moya
import CountryPicker


class LoginViewModel: BaseViewModel {
    
    @Published var loggedin: Bool = false
    @Published var isNotVerified: Bool = false
    
    private let apiService: AuthAPIClient
    
    init(apiService: AuthAPIClient = AuthAPIClient()) {
        self.apiService = apiService
    }
    
    func login(request: LoginRequest) {
        self.state = .loading
        apiService.login(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let value):
                self.state = .success
                self.handleSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
    override func handleSuccess<T>(_ value: T) {
        if let response = value as? LoginResponse {
            if let token = response.data?.token {
                UserDefaults.standard.set(token, forKey: Constants.beraerToken.rawValue)
                UserDefaults.standard.synchronize()
                
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
     func validateInputs(_ phoneNumber: String,_ password: String) -> Bool {
         
        if phoneNumber.isEmpty {
            
            self.errorMessage = "Phone Number Required"
            self.errorPopUp = true
            print("Validation failed: Phone number is empty") // Debug print
            return false
        }
        
        if password.isEmpty {
            self.errorMessage = "Password Required"
            self.errorPopUp = true
            print("Validation failed: phoneNumber number is empty") // Debug print
            return false
        }
        return true
    }
    
    func constructPhoneWithCodeCounty(_ phoneNumber: String, country: Country) -> String {
        return (country.dialingCode ?? "") + phoneNumber
    }
        
}
