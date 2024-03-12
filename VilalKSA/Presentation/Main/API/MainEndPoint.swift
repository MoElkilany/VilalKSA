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
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .mainAds,.mainCategory:
            return .get
        case .addOrRemoveFavourite:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .mainCategory:
            return .requestPlain
        case .mainAds(let requestObject):
            var parameters:[String : Any] = [:]
            if requestObject.lat == nil ||  requestObject.lon == nil {
                 parameters = ["category_id":requestObject.categoryID ?? "" ]
            }else{
                 parameters = ["lat": requestObject.lat ?? "" , "lon": requestObject.lon ?? "" ,"category_id":requestObject.categoryID ?? "" ]
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .addOrRemoveFavourite(let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.queryString )
 
        }
    }

    var headers: [String : String]? {
        let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
          let header : [String : String] = ["Accept": "application/json","locale": local]
        return header
    }

    var authorizationType: AuthorizationType? {
        switch self {
        case .mainAds,.mainCategory,.addOrRemoveFavourite:
            return .bearer
            }
        }
}
