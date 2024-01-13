//
//  Destination.swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//


import SwiftUI
import Combine

protocol Destination: Hashable, Equatable {
    associatedtype T: View
    @ViewBuilder var view: T { get }
    var name: String { get }
}


enum RootDestination: Destination {
    case splash
    case login
    case forgetPassword
    case verificationCode(phoneNumber:String,navigationChecker:NavigationChecker)
    case newPassword
    case createAccountPage
    case changePasswordSuccessPage
    case compeletProfilePage
    
    @ViewBuilder
    var view: some View {
        switch self {
        case.splash:
            SplashPage()
        case .login:
            LoginPage()
        case .forgetPassword:
            ForgetPasswordPage()
        case .verificationCode(let phoneNumber,let navigationChecker):
            VerificationCodePage(phoneNumber: phoneNumber,screenChecker:navigationChecker)
        case .newPassword:
            NewPasswordPage()
        case .createAccountPage:
            CreateAccountPage()
        case .changePasswordSuccessPage:
            ChangePasswordSuccessPage()
        case .compeletProfilePage:
            CompeletProfilePage()
        }
    }
    var name: String {
        return String(reflecting: view.self)
    }
}





