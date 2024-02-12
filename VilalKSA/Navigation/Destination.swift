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
    case forTest
    
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
        case .forTest:
            CustomerRequestsDetailsPage(requestID: "1")
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
    case customeRequest
    case customeRequestDetails(id:String)
    case todayAdsPage
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .services:
            ServicesPage()
        case .customeRequest:
            CustomerRequestsPage()
        case .customeRequestDetails(let id ):
            CustomerRequestsDetailsPage(requestID: id)
            
        case .todayAdsPage:
            TodayAdsPage()
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}

enum AddRequestDestination: Destination {
    case addRequest
    case services
    case addNewAdCategoryPage
    case addNewAdLocationPage(model:AddNewAdRequestModel)
    case propertyGalleryPage(model:AddNewAdRequestModel)
    case addNewAdsPage(model:AddNewAdRequestModel)
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .addRequest:
            AddRequestPage()
        case .services:
            ServicesPage()
        case .addNewAdCategoryPage:
            AddNewAdCategoryPage()
        case .addNewAdLocationPage(let model):
            AddNewAdLocationPage(addNewAdRequestModel: model)
        case .propertyGalleryPage(let model):
            PropertyGalleryPage(addNewAdRequestModel: model)
        case .addNewAdsPage(let model):
            AddNewAdsPage(addNewAdRequestModel: model)
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

enum MyAccountDestination: Destination {
    case myAccount
    case favorites
    case myAdsPage
    case myRequestsPage
    case myReservationsPage
    case aboutAppPage
    case languagePage
    case contactUsPage
    case cancellationTerms
    case termsAndConditions
    case privacyPolicy
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .myAccount:
            MyAccountPage()
        case .favorites:
            FavoritesPage()
        case .myAdsPage:
            MyAdsPage()
        case .myRequestsPage:
            MyRequestsPage()
        case .myReservationsPage:
            MyReservationsPage()
        case .aboutAppPage:
            AboutAppPage()
        case .languagePage:
            LanguagePage()
        case .contactUsPage:
            ContactUsPage()
        case .cancellationTerms:
            CancellationTermsPage()
        case .termsAndConditions:
            TermsAndConditionsPage()
        case .privacyPolicy:
            PrivacyPolicyPage()
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}



