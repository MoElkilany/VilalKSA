//
//  AddNewAdEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 10/02/2024.
//

import Moya

enum AddNewAdEndPoint {
    case getAdsCategory
}

extension AddNewAdEndPoint: TargetType, AccessTokenAuthorizable {
   
    
    var baseURL: URL {
        guard let url = URL(string: SharedAPIClient.shared.environment.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getAdsCategory:
            return Constants.adsCategory.rawValue
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAdsCategory:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAdsCategory:
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
        case .getAdsCategory :
            return .none
        }
    }
}
