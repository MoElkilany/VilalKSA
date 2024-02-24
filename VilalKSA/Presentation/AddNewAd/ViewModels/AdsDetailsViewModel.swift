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
    @Published var adDetails: AdDetailsValue = AdDetailsValue()
    @Published var mapDetails: Map?
        
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
    
    
    
}
