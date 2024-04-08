//
//  PaymentEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 01/04/2024.
//


import Moya

enum PaymentEndPoint {
    case getPayments
    case addPayments(model:AddPaymentRequestModel)
    case deletePayments(id: String)
    case updatePayments(id: String,model:AddPaymentRequestModel)
}

extension PaymentEndPoint: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        guard let url = URL(string: SharedAPIClient.shared.environment.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getPayments:
            return Constants.payments.rawValue
        case .addPayments:
            return Constants.addPayments.rawValue
        case .deletePayments(let id ):
            return Constants.deletePayments.rawValue  + id
        case .updatePayments(let id , _ ):
            return Constants.updatePayments.rawValue + id
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPayments,.deletePayments:
            return .get
        case .addPayments,.updatePayments:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPayments,.deletePayments:
            return .requestPlain
        case .addPayments(let model):
            return .requestJSONEncodable(model)
        case .updatePayments( _ , let model):
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
        case .getPayments,.addPayments,.deletePayments,.updatePayments:
            return .bearer
        }
    }
}
