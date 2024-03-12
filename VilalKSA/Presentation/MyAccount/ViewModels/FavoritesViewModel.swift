//
//  FavoritesViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import Moya
import SwiftUI

class FavoritesViewModel: BaseViewModel {
    
    private let apiMyAccount: MyAccountAPIClient
    @Published var favoriteList: [FavoriteModel]? = nil
    private var hasFetchedData = false
    
    init(apiMyAccount: MyAccountAPIClient = MyAccountAPIClient()) {
        self.apiMyAccount = apiMyAccount
    }
    
    func getFav() {
//    guard !hasFetchedData else {
//            return
//        }
        self.state = .loading
        apiMyAccount.getFav() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.handleSuccess(value)
//                self.hasFetchedData = true
            case .failure(let error):
                self.state = .error
                self.handle(error: error)
            }
        }
    }
    
    override func handleSuccess<T>(_ value: T) {
        
        if let response = value as? FavoriteResponseModel {
            guard let status = response.status else { return }
            
            if status == 200 {
                if response.data?.isEmpty == true  {
                    self.state = .noData
                }else{
                    self.state = .success
                    self.favoriteList = response.data ?? []
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
        apiMyAccount.addOrRemoveFavourite(id: id) { [weak self] result in
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
                self.getFav()
            } else {
                self.errorMessage = LocalizedStringKey(response.message ?? "")
                self.errorPopUp = true
            }
        } else {
            print("Error: Couldn't cast value to LoginResponse")
        }
    }
    
    
}
