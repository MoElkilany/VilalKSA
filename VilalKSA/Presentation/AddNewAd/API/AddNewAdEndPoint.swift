//
//  AddNewAdEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 10/02/2024.
//

import Moya

enum AddNewAdEndPoint {
    case getAdsCategory
    case getInterface
    case createNewAdd(video:Data,images:[Data],model:[String:String])
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAdsCategory ,.getInterface:
            return .get
        case .createNewAdd:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAdsCategory,.getInterface:
            return .requestPlain
        case .createNewAdd(let video,let images, let model):
         
            var multipartFormData = [MultipartFormData]()

            for (index, imageData) in images.enumerated() {
                let formData = MultipartFormData(provider: .data(imageData), name: "files[\(index)]", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                multipartFormData.append(formData)
            }

            let formData = MultipartFormData(provider: .data(video), name: "files[1000]", fileName: "video.mp4", mimeType: "video/mp4")
            multipartFormData.append(formData)
            
            
            return .uploadCompositeMultipart(multipartFormData, urlParameters: model)
        }
    }
    
    var headers: [String : String]? {
        let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
        let header : [String : String] = ["Accept": "application/json","locale": local]
        return header
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .getInterface,.getAdsCategory,.createNewAdd:
            return .bearer
        }
    }
}
