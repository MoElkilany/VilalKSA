//
//  ServicesEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 14/01/2024.
//

import Moya

enum ServicesEndPoint {
    case getServices
    case getCustomerRequests
    case getCustomerRequestDetails(id:String)
    case getTodayAds
    case createNewRequest(request:CreateCutomerRequestModel)
    case getAdsCategory
    case getRentalperiod
    case getResident
    case getInterface
    
}

extension ServicesEndPoint: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        guard let url = URL(string: SharedAPIClient.shared.environment.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getServices:
            return Constants.services.rawValue
        case .getCustomerRequests:
            return Constants.servicesCustomerRequests.rawValue
        case .getCustomerRequestDetails(let id ):
            return Constants.servicesCustomerRequestDetails.rawValue + id
        case .getTodayAds:
            return Constants.servicesTodayAds.rawValue
        case .createNewRequest:
            return Constants.createNewAds.rawValue
        case .getAdsCategory:
            return Constants.adsCategory.rawValue
            
        case .getRentalperiod:
            return Constants.rentalperiod.rawValue
        case .getResident:
            return Constants.resident.rawValue
        case .getInterface:
            return Constants.adsInterface.rawValue
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createNewRequest:
            return .post
        case .getServices,.getCustomerRequests,.getCustomerRequestDetails,.getTodayAds,.getAdsCategory,.getRentalperiod,.getResident,.getInterface:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
            
        case .createNewRequest(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .getServices,.getCustomerRequests,.getCustomerRequestDetails,.getTodayAds,.getAdsCategory,.getRentalperiod,.getResident,.getInterface:
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
        case .getServices,.getCustomerRequests,.getAdsCategory,.getCustomerRequestDetails,.getTodayAds,.createNewRequest,.getRentalperiod,.getResident,.getInterface:
            return .bearer
        }
    }
}
