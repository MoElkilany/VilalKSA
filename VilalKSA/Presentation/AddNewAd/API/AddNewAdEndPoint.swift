//
//  AddNewAdEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 10/02/2024.
//

struct changeAdStatusRequestModel: BaseModel{
    var type:String?
    var id:String?
}

import Moya

enum AddNewAdEndPoint {
    case getAdsCategory
    case getInterface
    case createNewAdd(video:Data?,images:[Data],model:[String:String])
    case getAdDetails(id:String)
    case addOrRemoveFavourite(id:String)
    case propertyOwnerInfo(id:String)
    case changeStatus(model:changeAdStatusRequestModel)
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
        case .getInterface:
            return Constants.adsInterface.rawValue
        case.createNewAdd:
            return Constants.createNewAds.rawValue
        case .getAdDetails(let id ):
            return Constants.adsDetails.rawValue + id 
        case .addOrRemoveFavourite:
            return Constants.addOrRemoveFavourite.rawValue
        case .propertyOwnerInfo(let id ):
            return Constants.propertyOwnerInfo.rawValue + id            
        case .changeStatus:
            return Constants.changeStatus.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAdsCategory ,.getInterface ,.getAdDetails,.propertyOwnerInfo :
            return .get
        case .createNewAdd,.addOrRemoveFavourite,.changeStatus:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAdsCategory,.getInterface,.getAdDetails,.propertyOwnerInfo:
            return .requestPlain
            
        case .createNewAdd(let video,let images, let model):
         
            var multipartFormData = [MultipartFormData]()

            for (index, imageData) in images.enumerated() {
                let formData = MultipartFormData(provider: .data(imageData), name: "files[\(index)]", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                multipartFormData.append(formData)
            }
            
            if video != nil {
                let formData = MultipartFormData(provider: .data(video!), name: "files[1000]", fileName: "video.mp4", mimeType: "video/mp4")
                multipartFormData.append(formData)
            }
            
            return .uploadCompositeMultipart(multipartFormData, urlParameters: model)
            
        case .addOrRemoveFavourite(let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.queryString )
        case .changeStatus(let model):
            return .requestJSONEncodable(model)
        }
    }
    
    var headers: [String : String]? {
        let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
        let header : [String : String] = ["Accept": "application/json","locale": local,"Accept-Language":local]
        return header
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .getInterface,.getAdsCategory,.createNewAdd,.getAdDetails,.addOrRemoveFavourite,.propertyOwnerInfo,.changeStatus:
            return .bearer
        }
    }
}
