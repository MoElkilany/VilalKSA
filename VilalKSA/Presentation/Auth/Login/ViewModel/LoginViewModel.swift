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
    
    @Published var phoneNumber = ""
    @Published var countryCode = ""
    @Published var fullNumber = ""
//    @Published var isPasswordValid = false
    
    var isValidUserName: Bool = false
    var isPasswordValid = false

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
                UserDefaults.standard.set(true, forKey: Constants.isLogin.rawValue)
                UserDefaults.standard.set(token, forKey: Constants.beraerToken.rawValue)
                UserDefaults.standard.synchronize()
                
            }
            loggedin = true
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
    func isValidForm() -> Bool {
       return isValidUserName && isPasswordValid
    }
    
    func constructPhoneWithCodeCounty(_ phoneNumber: String, country: Country) -> String {
        return (country.dialingCode ?? "") + phoneNumber
    }
    
   
}
