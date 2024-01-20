//
//  ServicesViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 14/01/2024.
//

import Moya
import SwiftUI
class ServicesViewModel: BaseViewModel {
    
    private let apiService: ServicesAPIClient
    @Published var servicesList: [ServicesResponse] = []
    
    init(apiService: ServicesAPIClient = ServicesAPIClient()) {
        self.apiService = apiService
    }
    
    func getServices() {
        self.state = .loading
        apiService.getServiceList() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.state = .serverError
                self.handleSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
    override func handleSuccess<T>(_ value: T) {
        if let response = value as? ServicesModel {
            guard let status = response.status else { return }
            if status == 200 {
                self.servicesList = response.data ?? []
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
}
