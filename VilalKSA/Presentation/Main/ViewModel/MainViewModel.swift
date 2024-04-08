//
//  MainViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 24/02/2024.
//

import Moya
import SwiftUI

class MainViewModel: BaseViewModel {

    private let apiService: MainAPIClient
    @Published var categorysList: [LookUpModel] = []
    @Published var mainAdsList: [MainAdsResponse] = []
    @Published var categorysError: String = ""
    @Published var testString: String = ""
    @Published var isFinishedFetch: Bool = false
    private var hasFetchedData = false
    private var hasFetchedAdsData = false

    init(apiService: MainAPIClient = MainAPIClient()) {
        self.apiService = apiService
    }
    
    func getMainCategory() {
        guard !hasFetchedData else {
            return
        }
        
        self.state = .loading
        apiService.mainCategory() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleSuccess(value)
                self.hasFetchedData = true 
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
                    self.categorysList = response.data ?? []
                    self.state = .success
                }
            } else {
                self.categorysError = (response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
    func getMainAds(request:MainAdRequest) {
        
        self.state = .loading
        apiService.getMainAds(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleMainAdSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
     func handleMainAdSuccess<T>(_ value: T) {
         
        if let response = value as? MainAdsModel {
            guard let status = response.status else { return }

            if status == 200 {
                self.mainAdsList = response.data ?? []
                self.state = .success
                self.isFinishedFetch = true
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
    func addOrRemoveFav(id:String) {
        apiService.addOrRemoveFavourite(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleAddOrRemoveFavSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
    
   func  handleAddOrRemoveFavSuccess<T>(_ value: T) {
        
        if let response = value as? BaseResponseModel {
            guard let status = response.status else { return }
            if status == 200 {
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
    func isSelectedAdAPI(id:String) {
        apiService.isSelectedAd(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleIsSelectedAdsSuccess(value)
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
    
   func  handleIsSelectedAdsSuccess<T>(_ value: T) {
        if let response = value as? BaseResponseModel {
            guard let status = response.status else { return }
            if status == 200 {
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
}
