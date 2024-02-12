//
//  AuthEndPoint.swift
//  VilalKSA
//
//  Created by Elkilany on 05/01/2024.
//

import Moya

enum AuthEndPoint {
    case login(request: LoginRequest)
    case registerPhone(request: RegisterPhoneRequest)
    case verificationCode(request:VerificationCodeRequest)
    case compeletProfile(request:CompleteProfileModelRequest)
    
    case forgetPassword(request:ForgetPasswordRequest)
    case codeForgetPassword(request:CodeForgetPasswordRequest)
    case changePassword(request:ChangePasswordRequest)
    case resendCode(request:ResendCodeRequest)
    
}

extension AuthEndPoint: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        guard let url = URL(string: SharedAPIClient.shared.environment.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return Constants.login.rawValue
        case .registerPhone:
            return Constants.registerPhone.rawValue
        case .verificationCode:
            return Constants.checkCode.rawValue
        case .compeletProfile:
            return Constants.completeProfile.rawValue
        case .forgetPassword:
            return Constants.forgetPassword.rawValue
        case .codeForgetPassword:
            return Constants.codeForgetPassword.rawValue
        case .changePassword:
            return Constants.changePassword.rawValue
        case .resendCode:
            return Constants.resendCode.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login,.registerPhone,.verificationCode,.compeletProfile,.forgetPassword,.codeForgetPassword,.changePassword,.resendCode:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .registerPhone(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .verificationCode(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .compeletProfile(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .forgetPassword(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .codeForgetPassword(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .changePassword(let requestObject):
            return .requestJSONEncodable(requestObject)
        case .resendCode(let requestObject):
            return .requestJSONEncodable(requestObject)
        }
    }
    
    var headers: [String : String]? {
        let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
        let header : [String : String] = ["Accept": "application/json","locale": local]
        return header
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .login , .registerPhone,.verificationCode,.forgetPassword,.codeForgetPassword,.resendCode:
            return .none
            
        case .compeletProfile,.changePassword:
            return .bearer
            
        }
    }
}
