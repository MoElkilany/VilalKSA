
//
//  SharedAPIClient.swift
//  SCISP
//
//  Created by Mostafa Aboghida on 07/05/2023.
//

import Moya
import UIPilot
import SwiftUI

enum APIEnvironment {
    case production
    case QA
    
    var baseUrl: String {
        switch SharedAPIClient.shared.environment {
        case .production: return Constants.proBaseUrl.rawValue
        case .QA: return Constants.qaBaseUrl.rawValue
        }
    }
    
    var apiUrl: String {
        switch SharedAPIClient.shared.environment {
        case .production, .QA:
            return baseUrl
        }
    }
}

class SharedAPIClient {
    static var shared = SharedAPIClient()
    let environment: APIEnvironment = .QA
}

protocol APIClient {
    var provider: MoyaProvider<MultiTarget> { get }
    func fetch<T: Decodable>(with target: TargetType, refreshCount: Int, completion: @escaping (APIResult<T, APIError>) -> Void)
}


extension APIClient {

    func fetch<T: Decodable>(with target: TargetType, refreshCount: Int = 0, completion: @escaping (APIResult<T, APIError>) -> Void) {
        provider.request(MultiTarget(target)) { result in
            switch result {
            case .success(let response):
                do {
                    if response.statusCode >= 300 {
                        let errorMessage = try response.map(ErrorMessage.self)
                        throw APIError.errorMessage(message: errorMessage.message, status: errorMessage.status)
                    } else {
                        let result = try JSONDecoder().decode(T.self, from: response.data)
                        completion(APIResult.success(result))
                    }
                } catch let err {
                    print("error: \(err)")
                    completion(APIResult.failure(APIError.mapError(err)))
                }
                
            case .failure(let error):
                print("error: \(error)")
                completion(APIResult.failure(APIError.mapError(error)))
            }
        }
    }
    
    
}
