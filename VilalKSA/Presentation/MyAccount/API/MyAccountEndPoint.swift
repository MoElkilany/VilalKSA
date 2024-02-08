//
//  MyAccountEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import Moya

enum MyAccountEndPoint {
    case login(request: LoginRequest)
    case getServices
    case getCustomerRequests
    case getCustomerRequestDetails(id:String)
    case getTodayAds
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
        case .getServices:
            return Constants.services.rawValue
        case .getCustomerRequests:
            return Constants.servicesCustomerRequests.rawValue
        case .getCustomerRequestDetails(let id ):
            return Constants.servicesCustomerRequestDetails.rawValue + id
        case .getTodayAds:
            return Constants.servicesTodayAds.rawValue
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .getServices,.getCustomerRequests,.getCustomerRequestDetails,.getTodayAds:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .getServices,.getCustomerRequests,.getCustomerRequestDetails,.getTodayAds:
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
        case .login,.getServices,.getCustomerRequests,.getCustomerRequestDetails,.getTodayAds:
                return .none
            }
        }
}
