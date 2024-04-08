//
//  MyPersonalCardsViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 01/04/2024.
//

import Moya
import SwiftUI
class MyPersonalCardsViewModel: BaseViewModel {

    private let apiService: PaymentAPIClient
    @Published var paymentsList: [PaymentsModel] = []
    @Published var deleteState: AppState = .success

    @Published var successBottomSheet: Bool = false
    @Published var successTitle: String = ""
    
    init(apiService: PaymentAPIClient = PaymentAPIClient()) {
        self.apiService = apiService
    }
    
    func getPayment(withState:Bool = true ) {
        if withState == true {
            self.state = .loading
        }

        apiService.getPayments() { [weak self] result in
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

        if let response = value as? PaymentsResponseModel {
            guard let status = response.status else { return }

            if status == 200 {
                if response.data?.isEmpty == true  {
                    self.state = .noData
                }else{
                    self.state = .success
                    self.paymentsList = response.data ?? []
                }
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
    func deleteMyRequest(id: String) {
        self.deleteState = .loading
        apiService.deletePayment(id:id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleDeleteSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
    
    
    func handleDeleteSuccess<T>(_ value: T) {
       if let response = value as? PaymentsResponseModel {
           guard let status = response.status else { return }
           if status == 200 {
               self.deleteState = .success
               self.getPayment(withState: false)
               self.successBottomSheet = true
               self.successTitle = response.message ?? ""
           } else {
               self.errorMessage = LocalizedStringKey(response.message ?? "")
               self.errorPopUp = true
           }
       } else {
           print("Error: Couldn't cast value to LoginResponse")
       }
   }
    
    
}
