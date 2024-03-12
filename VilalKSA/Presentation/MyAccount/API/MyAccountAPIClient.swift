//
//  MyAccountAPIClient.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//


import Moya
struct MyAccountAPIClient: APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
                                                       AccessTokenPlugin(tokenClosure: { _ in
        return UserDefaults.standard.string(forKey: Constants.beraerToken.rawValue) ?? ""
    })])
    
    func getProfileData(completion: @escaping (APIResult<MyAccountResponseModel?, APIError>) -> Void) {
        fetch(with: MyAccountEndPoint.getProfile, completion: completion)
    }
    
    func getFav(completion: @escaping (APIResult<FavoriteResponseModel?, APIError>) -> Void) {
        fetch(with: MyAccountEndPoint.getFavourite, completion: completion)
    }
    
    func addOrRemoveFavourite(id:String , completion: @escaping (APIResult<BaseResponseModel?, APIError>) -> Void) {
        fetch(with: MyAccountEndPoint.addOrRemoveFavourite(id: id), completion: completion)
    }
        
    func getMyAds(completion: @escaping (APIResult<MyAdsResponseModel?, APIError>) -> Void) {
        fetch(with: MyAccountEndPoint.myAds, completion: completion)
    }
    
    func deleteMyAds(request:deleteMyAdsRequest, completion: @escaping (APIResult<BaseResponseModel?, APIError>) -> Void) {
        fetch(with: MyAccountEndPoint.deleteMyAds(request: request), completion: completion)
    }
    
    func getMyRequest(completion: @escaping (APIResult<MyRequestResponseModel?, APIError>) -> Void) {
        fetch(with: MyAccountEndPoint.myRequest, completion: completion)
    }
    
    func deleteMyRequest(request:deleteMyAdsRequest, completion: @escaping (APIResult<BaseResponseModel?, APIError>) -> Void) {
        fetch(with: MyAccountEndPoint.deleteMyRequest(request: request), completion: completion)
    }
}
