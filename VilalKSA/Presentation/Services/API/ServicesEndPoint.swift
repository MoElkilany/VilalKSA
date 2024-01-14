//
//  ServicesEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 14/01/2024.
//

import Moya

enum ServicesEndPoint {
    case login(request: LoginRequest)
    case getServices

}

extension ServicesEndPoint: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        guard let url = URL(string: SharedAPIClient.shared.environment.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return Constants.login.rawValue
        case .getServices:
            return Constants.services.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .getServices:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .getServices:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var header : [String : String] = ["Accept": "application/json",
                                                      "Accept-Language": "ar" ]
        return header
    }

    var authorizationType: AuthorizationType? {
        switch self {
        case .login,.getServices:
                return .none
            }
        }
}
