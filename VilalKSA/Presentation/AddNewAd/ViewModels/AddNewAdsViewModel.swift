//
//  AddNewAdsViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 16/02/2024.
//

import Moya
import SwiftUI

class AddNewAdsViewModel: BaseViewModel {
    
    private let apiService: AddNewAdAPIClient
    
    private let servicesApiService: ServicesAPIClient

    @Published var adsInterfaceList: [LookUpModel] = []
    @Published var rentalPeriodList: [LookUpModel] = []
    @Published var residentList: [LookUpModel] = []

    @Published var sucessAddRequest: Bool = false
    @Published var createAdsState: AppState = .success
    
    
    @Published  var residentID: String = ""
    @Published  var rentalID: String = ""
    
    @Published var isRental: Bool = false

    var isValidArea = false
    var isPriceValid = false
    var isPropertyDetailsValid = false
    var isPropertyNameValid = false
    
    init(apiService: AddNewAdAPIClient = AddNewAdAPIClient(),servicesApiService: ServicesAPIClient = ServicesAPIClient()) {
        self.apiService = apiService
        self.servicesApiService = servicesApiService
    }
    

    
    func getAdsInterfaceList() {
        self.state = .loading
        apiService.getAdsInterfaceList() { [weak self] result in
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
    
    
    
    func createNewAds(video:Data?,images: [Data], model: [String:String]) {
        createAdsState = .loading
        apiService.createNewAdd(video: video, images: images, model: model) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleCreateNewAdSuccess(value)
            case .failure(let error):
                self.handleCreateNewAd(error: error)
            }
        }
    }
    
    
    func handleCreateNewAd(error: APIError) {
        createAdsState = .error
        switch error {
        case .errorMessage(let message, _):
            print("Error Message: \(message)")
            self.errorPopUp = true
            self.errorMessage = LocalizedStringKey(message)
        default:
            print("An unknown error occurred.")
            self.errorPopUp = true
            self.errorMessage = (R.string.localizable.unknown_Error_Occurred.localized)
        }
    }
    
    func handleCreateNewAdSuccess<T>(_ value: T) {
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
    
    
    func isValidForm() -> Bool {
        if isRental {
          return isValidArea && isPriceValid && isPropertyDetailsValid && !residentID.isEmpty && !rentalID.isEmpty
        }else{
            return isValidArea && isPriceValid && isPropertyDetailsValid
        }
    }
    
    
    func getRentalPeriodList() {
        self.state = .loading
        servicesApiService.getRentalperiodList() { [weak self] result in
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
        servicesApiService.getResidentList() { [weak self] result in
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
   
    
    
    
}
