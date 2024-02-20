//
//  AddCustomerRequestsViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 16/02/2024.
//

import Moya
import SwiftUI

class AddCustomerRequestsViewModel: BaseViewModel {
    
    private let apiService: ServicesAPIClient
    @Published var adsCategoryList: [AdsCategoryResponse] = []
    @Published var adsInterfaceList: [LookUpModel] = []

    @Published var rentalPeriodList: [LookUpModel] = []
    @Published var residentList: [LookUpModel] = []

    @Published var sucessAddRequest: Bool = false
    @Published  var createAdsState: AppState = .success

    var isCategoryIdValid = false
    var isPriceFromValid = false
    var isPriceToValid = false
    var isPropertyDetailsValid = false
    var isPropertyNameValid = false

    init(apiService: ServicesAPIClient = ServicesAPIClient()) {
        self.apiService = apiService
    }
    
    
    func getAdsInterfaceList() {
        self.state = .loading
        apiService.getAdsInterfaceList() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleInterfaceListSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
    
    func handleInterfaceListSuccess<T>(_ value: T) {
       
       if let response = value as? LookUpResponse {
           guard let status = response.status else { return }
           
           if status == 200 {
               if response.data?.isEmpty == true  {
                   self.state = .noData
               }else{
                   self.state = .success
                   self.adsInterfaceList = response.data ?? []
               }
           } else {
               self.errorMessage = LocalizedStringKey(response.message ?? "")
               self.errorPopUp = true
           }
       } else {
           print("Error: Couldn't cast value to LoginResponse")
       }
   }
    
    
    func getAdsCategoryList() {
        self.state = .loading
        apiService.getAdsCategoryList() { [weak self] result in
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
        if let response = value as? AdsCategoryModel {
            guard let status = response.status else { return }
            if status == 200 {
                if response.data?.isEmpty == true  {
                    self.state = .noData
                }else{
                    self.state = .success
                    self.adsCategoryList = response.data ?? []
                }
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    func getRentalPeriodList() {
        self.state = .loading
        apiService.getRentalperiodList() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleRentalPeriodListSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }

     func handleRentalPeriodListSuccess<T>(_ value: T) {
        
        if let response = value as? LookUpResponse {
            guard let status = response.status else { return }
            
            if status == 200 {
                if response.data?.isEmpty == true  {
                    self.state = .noData
                }else{
                    self.state = .success
                    self.rentalPeriodList = response.data ?? []
                }
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
    
    func getResidentList() {
        self.state = .loading
        apiService.getResidentList() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleResidentListSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }

     func handleResidentListSuccess<T>(_ value: T) {
        if let response = value as? LookUpResponse {
            guard let status = response.status else { return }
            if status == 200 {
                if response.data?.isEmpty == true  {
                    self.state = .noData
                }else{
                    self.state = .success
                    self.residentList = response.data ?? []
                }
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
    
    func createNewRequest(model:CreateCutomerRequestModel) {
                    createAdsState = .loading
        apiService.createCutomerRequest(request: model) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let value):
                            self.handleCreateNewRequestSuccess(value)
                        case .failure(let error):
                            self.handleCreateRequestError(error: error)
                        }
                    }
                }
            
            
                func handleCreateRequestError(error: APIError) {
                    createAdsState = .error
                    switch error {
                    case .errorMessage(let message, _):
                        print("Error Message: \(message)")
                        self.errorPopUp = true
                        self.errorMessage = LocalizedStringKey(message)
                    default:
                        print("An unknown error occurred.")
                        self.errorPopUp = true
                        self.errorMessage = "An unknown error occurred."
            
                    }
                }
            
                func handleCreateNewRequestSuccess  <T>(_ value: T) {
                    if let response = value as? CreateNewAdsResponseModel {
                        guard let status = response.status else { return }
                        createAdsState = .success
                        if status == 200 {
                            sucessAddRequest = true
                        } else {
                            createAdsState = .error
                            self.errorMessage = LocalizedStringKey(response.message ?? "")
                            self.errorPopUp = true
                        }
                    } else {
                        print("Error: Couldn't cast value to LoginResponse")
                    }
                }
            //
            
           
             
        
    
    func isValidForm() -> Bool {
        isPriceFromValid && isPriceToValid && isPropertyDetailsValid && isPropertyNameValid
    }
}
