//
//  AuthAPIClient.swift
//  VilalKSA
//
//  Created by Elkilany on 05/01/2024.
//

import Moya
struct AuthAPIClient: APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
                                                       AccessTokenPlugin(tokenClosure: { _ in
        return UserDefaults.standard.string(forKey: Constants.beraerToken.rawValue) ?? ""
    })])
    
    func login(request: LoginRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.login(request: request), completion: completion)
    }
    
    func registerPhone(request: RegisterPhoneRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.registerPhone(request: request), completion: completion)
    }
    
    func verificationCode(request: VerificationCodeRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.verificationCode(request: request), completion: completion)
    }

    func compeletProfile(request: CompleteProfileModelRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.compeletProfile(request: request), completion: completion)
    }
    
    func forgetPassword(request: ForgetPasswordRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.forgetPassword(request: request), completion: completion)
    }
    
    func codeForgetPassword(request: CodeForgetPasswordRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.codeForgetPassword(request: request), completion: completion)
    }
    
    func changePassword(request: ChangePasswordRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.changePassword(request: request), completion: completion)
    }
    
    func resendCode(request: ResendCodeRequest, completion: @escaping (APIResult<LoginResponse?, APIError>) -> Void) {
        fetch(with: AuthEndPoint.resendCode(request: request), completion: completion)
    }
}

