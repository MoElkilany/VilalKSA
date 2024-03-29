//
//  ForgetPasswordViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 11/01/2024.
//


import Moya
import CountryPicker

class ForgetPasswordViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var state: AppState = .success
    @Published var errorPopUp: Bool = false
    @Published var errorMessage: String = "Phone Number Required"
    @Published var isNotVerified: Bool = false
    
    // MARK: - Private Properties
    
    private let apiService: AuthAPIClient
    private var cancellable: Cancellable?
    
    // MARK: - Initialization
    
    init(apiService: AuthAPIClient = AuthAPIClient()) {
        self.apiService = apiService
    }
    
    // MARK: - Public Methods
    
    func forgetPasswordRequest(request: ForgetPasswordRequest) {
        self.state = .loading
        self.cancelRequest()
        
        self.cancellable = apiService.forgetPassword(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleSuccess(value)
            case .failure(let error):
                self.handleError(error)
            }
        } as? any Cancellable
    }
    
    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        if phoneNumber.isEmpty {
            errorMessage = "Phone Number Required"
            errorPopUp = true
            return false
        }
        let digitsOnly = phoneNumber.allSatisfy { $0.isNumber }
        if !digitsOnly {
            errorMessage = "Invalid Phone Number"
            errorPopUp = true
        }
        return digitsOnly
    }
    
    func constructPhoneWithCodeCounty(_ phoneNumber: String, country: Country) -> String {
        return (country.dialingCode ?? "") + phoneNumber
    }
    
    // MARK: - Private Methods
    
    private func handleSuccess(_ value: LoginResponse?) {
        self.state = .success
        guard let status = value?.status else { return }
        
        if status == 200 {
            self.isNotVerified = true
        } else {
            self.errorMessage = value?.message ?? ""
            self.showErrorPopup()
        }
    }
    
    private func handleError(_ error: APIError) {
        self.state = .error
        
        switch error {
        case .errorMessage(let message, _):
            self.errorMessage = message
        default:
            self.errorMessage = "An unknown error occurred."
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
}

