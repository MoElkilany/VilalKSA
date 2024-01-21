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
    case home
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
        case .home:
            HomeScreen()
        }
    }
    var name: String {
        return String(reflecting: view.self)
    }
}


enum HomeDestination: Destination {
    case home
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            HomeScreen()
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}


enum MainDestination: Destination {
    case main
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .main:
            MainPage()
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}

enum ServicesDestination: Destination {
    case services
    case customerOrder
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .services:
            ServicesPage()
        case .customerOrder:
            CustomerOrdersPage()
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}

enum AddRequestDestination: Destination {
    case addRequest
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .addRequest:
            AddRequestPage()
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}

enum MessageDestination: Destination {
    case message
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .message:
            MessagesPage()
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}


enum MyAcoountDestination: Destination {
    case myAccount
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .myAccount:
            MyAccountPage()
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}



