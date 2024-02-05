//
//  ServicesAPIClient.swift
//  VilalKSA
//
//  Created by Elkilany on 14/01/2024.
//

import Moya
struct ServicesAPIClient: APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
                                                       AccessTokenPlugin(tokenClosure: { _ in
        return UserDefaults.standard.string(forKey: Constants.beraerToken.rawValue) ?? ""
    })])
    
    func login(request: LoginRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.login(request: request), completion: completion)
    }
    
    func getServiceList(completion: @escaping (APIResult<ServicesModel?, APIError>) -> Void) {
        fetch(with: ServicesEndPoint.getServices, completion: completion)
    }
    
    func getCustomerRequests(completion: @escaping (APIResult<CustomerRequestsModel?, APIError>) -> Void) {
        fetch(with: ServicesEndPoint.getCustomerRequests, completion: completion)
    }

    func getCustomerRequestDetails(id: String ,completion: @escaping (APIResult<CustomerRequestsDetailsModel?, APIError>) -> Void) {
        fetch(with: ServicesEndPoint.getCustomerRequestDetails(id: id), completion: completion)
    }
    
    func getTodayAds(completion: @escaping (APIResult<TodayAdsModel?, APIError>) -> Void) {
        fetch(with: ServicesEndPoint.getTodayAds, completion: completion)
    }
}
