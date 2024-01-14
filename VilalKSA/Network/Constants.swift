//
//  Constants.swift
//  VilalKSA
//
//  Created by Elkilany on 04/01/2024.
//

import Foundation
enum Constants: String {

    case proBaseUrl             = "https://scispmobdemo.sure.com.sa/api"
    case qaBaseUrl              = "https://verasign.se/ammr/public/api/"
    case apiUrl                 = "api"
    case beraerToken            = "beraerToken"
    case userModel
    
    // MARK: - API Paths
    case login = "Auth/login"
    case registerPhone = "Auth/register/phone"
    case checkCode = "Auth/check/code"
    case completeProfile = "Auth/register/personal/data"
    case forgetPassword = "Auth/forget/password"
    case codeForgetPassword = "Auth/code/forget/password"
    case changePassword = "Auth/change/password"
    case resendCode     = "Auth/resend/code"
    case services     = "services"

}
