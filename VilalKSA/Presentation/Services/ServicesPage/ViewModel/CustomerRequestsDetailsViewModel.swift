//
//  CustomerRequestsDetailsViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 30/01/2024.
//

import Foundation
import SwiftUI

class CustomerRequestsDetailsViewModel: BaseViewModel {
    
    private let apiService: ServicesAPIClient
    @Published var customerRequestDetailsModel: CustomerRequestsValueModel = CustomerRequestsValueModel()
    
    init(apiService: ServicesAPIClient = ServicesAPIClient()) {
        self.apiService = apiService
    }
    
    func getCustomerRequestDetails(requestID: String) {
        self.state = .loading
        apiService.getCustomerRequestDetails(id: requestID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
    override func handleSuccess<T>(_ value: T) {
        if let response = value as? CustomerRequestsDetailsModel {
            guard let status = response.status else { return }
            
            if status == 200 {
                
                if let responseData = response.data {
                    self.state = .success
                    guard let responseData = response.data else {return}
                    self.customerRequestDetailsModel = responseData
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
    
    
    
}
