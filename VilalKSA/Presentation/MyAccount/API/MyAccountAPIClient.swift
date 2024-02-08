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
    
    func login(request: LoginRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.login(request: request), completion: completion)
    }
    
}
