//
//  AddNewAdAPIClient.swift
//  VilalKSA
//
//  Created by Elkilany on 10/02/2024.
//

import Moya
struct AddNewAdAPIClient: APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
                                                       AccessTokenPlugin(tokenClosure: { _ in
        return UserDefaults.standard.string(forKey: Constants.beraerToken.rawValue) ?? ""
    })])
    
  
    func getAdsCategoryList(completion: @escaping (APIResult<AdsCategoryModel?, APIError>) -> Void) {
        fetch(with: AddNewAdEndPoint.getAdsCategory, completion: completion)
    }
    
    func getAdsInterfaceList(completion: @escaping (APIResult<LookUpResponse?, APIError>) -> Void) {
        fetch(with: AddNewAdEndPoint.getInterface, completion: completion)
    }
    
    func createNewAdd(video:Data,images: [Data], model: [String:String],completion: @escaping (APIResult<CreateNewAdsResponseModel?, APIError>) -> Void) {
        fetch(with: AddNewAdEndPoint.createNewAdd(video: video, images: images, model: model), completion: completion)
    }
}
