//
//  PaymentAPIClient.swift
//  VilalKSA
//
//  Created by Elkilany on 01/04/2024.
//


import Moya
struct PaymentAPIClient: APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
                                                       AccessTokenPlugin(tokenClosure: { _ in
        return UserDefaults.standard.string(forKey: Constants.beraerToken.rawValue) ?? ""
    })])
    
    
    func getPayments(completion: @escaping (APIResult<PaymentsResponseModel?, APIError>) -> Void) {
        fetch(with: PaymentEndPoint.getPayments, completion: completion)
    }
    
    
    func addPayments(model:AddPaymentRequestModel ,completion: @escaping (APIResult<PaymentsResponseModel?, APIError>) -> Void) {
        fetch(with: PaymentEndPoint.addPayments(model: model), completion: completion)
    }
    
    func deletePayment(id:String ,completion: @escaping (APIResult<PaymentsResponseModel?, APIError>) -> Void) {
        fetch(with: PaymentEndPoint.deletePayments(id: id), completion: completion)
    }
    
    func editPayments(id:String ,model:AddPaymentRequestModel ,completion: @escaping (APIResult<PaymentsResponseModel?, APIError>) -> Void) {
        fetch(with: PaymentEndPoint.updatePayments(id: id, model: model), completion: completion)
    }
    
    
}

