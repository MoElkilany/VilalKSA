//
//  AddNewAdCategoryViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 11/02/2024.
//

import Moya
import SwiftUI
class AddNewAdCategoryViewModel: BaseViewModel {

    private let apiService: AddNewAdAPIClient
    @Published var adsCategoryList: [AdsCategoryResponse] = []
    
    init(apiService: AddNewAdAPIClient = AddNewAdAPIClient()) {
        self.apiService = apiService
    }
    
    
    
    func convertImageToData(images:[UIImage])-> [Data]{
        var arrayOfData: [Data] = []
        for image in images {
            if let imageData = image.pngData() {
                arrayOfData.append(imageData)
            }
        }
        return arrayOfData
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
    
}
