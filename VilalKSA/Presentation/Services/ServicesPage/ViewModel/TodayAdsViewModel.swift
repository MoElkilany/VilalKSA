//
//  TodayAdsViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 05/02/2024.
//

import Moya
import SwiftUI
class TodayAdsViewModel: BaseViewModel {

    private let apiService: ServicesAPIClient
    @Published var todayAdsList: [todayAdsValue] = []



    init(apiService: ServicesAPIClient = ServicesAPIClient()) {
        self.apiService = apiService
    }
    
    
    func getTodayAds() {
        self.state = .loading
        apiService.getTodayAds() { [weak self] result in
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

        if let response = value as? TodayAdsModel {
            guard let status = response.status else { return }

            if status == 200 {
                if response.data?.isEmpty == true  {
                    self.state = .noData
                }else{
                    self.todayAdsList = response.data ?? []
                    self.state = .success
                }
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
    
}
