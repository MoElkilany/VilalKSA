//
//  MainAPIClient.swift
//  VilalKSA
//
//  Created by Elkilany on 24/02/2024.
//


import Moya
struct MainAPIClient: APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
                                                       AccessTokenPlugin(tokenClosure: { _ in
        return UserDefaults.standard.string(forKey: Constants.beraerToken.rawValue) ?? ""
    })])
    
    func getMainAds(request: MainAdRequest, completion: @escaping (APIResult<MainAdsModel?, APIError>) -> Void) {
        fetch(with: MainEndPoint.mainAds(request: request), completion: completion)
    }
    
    
    func mainCategory( completion: @escaping (APIResult<LookUpResponse?, APIError>) -> Void) {
        fetch(with: MainEndPoint.mainCategory, completion: completion)
    }
    
  
    func addOrRemoveFavourite(id:String , completion: @escaping (APIResult<BaseResponseModel?, APIError>) -> Void) {
        fetch(with: MainEndPoint.addOrRemoveFavourite(id: id), completion: completion)
    }
    
    func isSelectedAd(id:String , completion: @escaping (APIResult<BaseResponseModel?, APIError>) -> Void) {
        fetch(with: MainEndPoint.isSelectedAd(id: id), completion: completion)
    }
    
    
}
