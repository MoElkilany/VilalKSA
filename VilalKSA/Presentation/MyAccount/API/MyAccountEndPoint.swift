//
//  MyAccountEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import Moya
struct deleteMyAdsRequest:BaseModel {
var id: String?
}

enum MyAccountEndPoint {
    case getProfile
    case getFavourite
    case addOrRemoveFavourite(id:String)
    case myAds
    case deleteMyAds(request:deleteMyAdsRequest)
    case myRequest
    case deleteMyRequest(request:deleteMyAdsRequest)
}

extension MyAccountEndPoint: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        guard let url = URL(string: SharedAPIClient.shared.environment.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getProfile:
            return Constants.profile.rawValue
        case .getFavourite:
            return Constants.favourite.rawValue
        case .addOrRemoveFavourite:
            return Constants.addOrRemoveFavourite.rawValue
        case .myAds:
            return Constants.myAds.rawValue
        case .deleteMyAds:
            return Constants.deleteMyAds.rawValue
        case .myRequest:
            return Constants.myRequest.rawValue
        case .deleteMyRequest:
            return Constants.deleteMyRequest.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfile,.getFavourite,.myAds,.myRequest:
            return .get
        case .addOrRemoveFavourite,.deleteMyAds,.deleteMyRequest:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getProfile,.getFavourite,.myAds,.myRequest:
            return .requestPlain
        case .addOrRemoveFavourite(let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.queryString )
        case .deleteMyAds(let request):
            return .requestJSONEncodable(request)
            
        case .deleteMyRequest(let request):
            return .requestJSONEncodable(request)
        }
    }

    var headers: [String : String]? {
        let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
        let header : [String : String] = ["Accept": "application/json","locale": local,"Accept-Language":local]
        return header
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .getProfile,.getFavourite,.addOrRemoveFavourite,.myAds,.deleteMyAds,.myRequest,.deleteMyRequest:
            return .bearer
        }
    }
}
