//
//  PropertyOwnerViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 31/03/2024.
//

import Moya
import SwiftUI

class PropertyOwnerViewModel: BaseViewModel {

    private let apiService: AddNewAdAPIClient
    @Published var propertyOwnerData: PropertyOwnerData =  PropertyOwnerData()
    
    init(apiService: AddNewAdAPIClient = AddNewAdAPIClient()) {
        self.apiService = apiService
    }
    
        
    func getPropertyOwnerInfo(id:String) {
        self.state = .loading
        apiService.getPropertyOwnerData(id:id) { [weak self] result in
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

        if let response = value as? PropertyOwnerModel {
            guard let status = response.status else { return }

            if status == 200 {
                if response.data == nil  {
                    self.state = .noData
                }else{
                    self.state = .success
                    self.propertyOwnerData = response.data ?? PropertyOwnerData()
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
