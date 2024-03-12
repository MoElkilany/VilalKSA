//
//  AdsDetailsViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 23/02/2024.
//

import Foundation
import SwiftUI

class AdsDetailsViewModel: BaseViewModel {
    
    private let apiService: AddNewAdAPIClient
    @Published var adDetails: AdDetailsValue? 
    @Published var mapDetails: Map?
    @Published var videoUrl: String?
    @Published var imageUrls: [String]?
    
    init(apiService: AddNewAdAPIClient = AddNewAdAPIClient()) {
        self.apiService = apiService
    }
    
    func getAdDetails(requestID: String) {
        self.state = .loading
     
     
        apiService.getAdDetails(id: requestID) { [weak self] result in
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
        if let response = value as? AdDetailsModel {
            guard let status = response.status else { return }
            if status == 200 {
                if let responseData = response.data {
                    self.mapDetails = responseData.map
                    self.state = .success
                    let images = responseData.images
                    self.videoUrl = images?.filter { $0.hasSuffix(".mp4") }.first
                    self.imageUrls = images?.filter { !$0.hasSuffix(".mp4") }
                    self.adDetails = responseData
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
