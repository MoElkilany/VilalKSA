//
//  MainEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 24/02/2024.
//

import Moya

enum MainEndPoint {
    case mainAds(request: MainAdRequest)
    case mainCategory
    case addOrRemoveFavourite(id:String)
    case isSelectedAd(id:String)

}

extension MainEndPoint: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        guard let url = URL(string: SharedAPIClient.shared.environment.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .mainCategory:
            return Constants.adsCategory.rawValue
        case .mainAds:
            return Constants.mainAds.rawValue
        case .addOrRemoveFavourite:
            return Constants.addOrRemoveFavourite.rawValue
        case .isSelectedAd:
            return  Constants.selectedAds.rawValue
            
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .mainAds,.mainCategory:
            return .get
        case .addOrRemoveFavourite,.isSelectedAd:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .mainCategory:
            return .requestPlain
        case .mainAds(let requestObject):
            let parameters = ["category_id":requestObject.categoryID ?? "","lat": requestObject.lat ?? "","lon": requestObject.lon ?? "","price": requestObject.price ?? "","room": requestObject.room ?? "","bathrooms": requestObject.bathrooms ?? "","lounges": requestObject.lounges ?? "","sort": requestObject.sort ?? ""]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .addOrRemoveFavourite(let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.queryString)
        case .isSelectedAd(let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
          let header : [String : String] = ["Accept": "application/json","locale": local,"Accept-Language":local]
        return header
    }

    var authorizationType: AuthorizationType? {
        switch self {
        case .mainAds,.mainCategory,.addOrRemoveFavourite,.isSelectedAd:
            return .bearer
            }
        }
}
