//
//  AddPersonalCardViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 19/03/2024.
//

import Foundation
import SwiftUI

class AddPersonalCardViewModel: BaseViewModel {
    
    private let apiService: PaymentAPIClient
    
    @Published var customerRequestDetailsModel: CustomerRequestsDetailsValue = CustomerRequestsDetailsValue()
    @Published var mapDetails: Map?
    @Published var isSucess: Bool = false
    @Published var isEditSucess: Bool = false
    
    var isOwnerCardNameValid = false
    var isCardNumberValid = false
    var isEndDateValid = false
    var isCVValid = false

    init(apiService: PaymentAPIClient = PaymentAPIClient()) {
        self.apiService = apiService
    }
    
    func addCard(requestModel: AddPaymentRequestModel) {
        self.state = .loading
        apiService.addPayments(model: requestModel) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleSuccess(value)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
    
    override func handleSuccess<T>(_ value: T) {
        if let response = value as? PaymentsResponseModel {
            guard let status = response.status else { return }
            if status == 200 {
                if response.data != nil {
                    self.state = .success
                    self.isSucess = true
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
    
    
    func editCard(id: String, requestModel: AddPaymentRequestModel) {
        self.state = .loading
        apiService.editPayments(id: id, model: requestModel ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleEditSuccess(value)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
    
     func handleEditSuccess<T>(_ value: T) {
        if let response = value as? PaymentsResponseModel {
            guard let status = response.status else { return }
            if status == 200 {
                if response.data != nil {
                    self.state = .success
                    self.isSucess = true
                    self.isEditSucess = true
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
    
    func isValidForm() -> Bool {
        isOwnerCardNameValid && isCardNumberValid && isEndDateValid && isCVValid
    }
}
