//
//  MyRequestsViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//
import Moya
import SwiftUI

class MyRequestsViewModel: BaseViewModel {
    
    private let apiMyAccount: MyAccountAPIClient
    @Published var myRequestList: [MyRequestModel]? = nil
    @Published var successBottomSheet: Bool = false
    @Published var successTitle: String = ""
    @Published var deleteState: AppState = .success
    
    init(apiMyAccount: MyAccountAPIClient = MyAccountAPIClient()) {
        self.apiMyAccount = apiMyAccount
    }
    
    func getMyRequest(withState:Bool = true ) {
        if withState == true {
            self.state = .loading
        }
       
        apiMyAccount.getMyRequest() { [weak self] result in
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
        if let response = value as? MyRequestResponseModel {
            guard let status = response.status else { return }

            if status == 200 {
                if response.data?.isEmpty == true  {
                    self.state = .noData
                }else{
                    self.state = .success
                    self.myRequestList = response.data ?? []
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
        apiMyAccount.deleteMyRequest(request: deleteMyAdsRequest(id: id)) { [weak self] result in
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
       if let response = value as? BaseResponseModel {
           guard let status = response.status else { return }
           if status == 200 {
               self.deleteState = .success
               self.getMyRequest(withState: false)
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
