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
    case getCustomerRequests
    case getCustomerRequestDetails(id:String)
    case getTodayAds
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
        let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
          let header : [String : String] = ["Accept": "application/json","locale": local]
        return header
    }

    var authorizationType: AuthorizationType? {
        switch self {
        case .login,.getServices,.getCustomerRequests,.getCustomerRequestDetails,.getTodayAds:
                return .none
            }
        }
}
