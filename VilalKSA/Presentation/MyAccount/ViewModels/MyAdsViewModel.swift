//
//  MyAdsViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//

import Moya
import SwiftUI

class MyAdsViewModel: BaseViewModel {

    private let apiMyAccount: MyAccountAPIClient
    @Published var servicesList: [ServicesResponse] = []
    
    init(apiMyAccount: MyAccountAPIClient = MyAccountAPIClient()) {
        self.apiMyAccount = apiMyAccount
    }
    
    func getServices() {
        self.state = .loading
//        apiMyAccount.getServiceList() { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let value):
//                self.handleSuccess(value)
//            case .failure(let error):
//                self.state = .error
//                self.handle(error: error)
//            }
//        }
    }
    
    override func handleSuccess<T>(_ value: T) {

        if let response = value as? ServicesModel {
            guard let status = response.status else { return }

            if status == 200 {
                if response.data?.isEmpty == true  {
                    self.state = .noData
                }else{
                    self.state = .success
                    self.servicesList = response.data ?? []
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
