//
//  MyAccountEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import Moya

enum MyAccountEndPoint {
    case login(request: LoginRequest)

}

extension MyAccountEndPoint: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        guard let url = URL(string: SharedAPIClient.shared.environment.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return Constants.login.rawValue
   
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
      
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let requestObject):
            return .requestJSONEncodable(requestObject)
       
        }
    }
    
    var headers: [String : String]? {
        let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
          let header : [String : String] = ["Accept": "application/json","locale": local]
        return header
    }

    var authorizationType: AuthorizationType? {
        switch self {
        case .login: 
                return .none
            }
        }
}
