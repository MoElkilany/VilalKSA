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
            AddNewAdsPage(addNewAdRequestModel: nil)
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
    case adsDetailsPage(id:String,type:AdDetailsTypes)
    case mainListPage(mainAdsList: [MainAdsResponse])
    case propertySummaryPage(model:SummaryModel,type:AdDetailsTypes)
    case paymentMethodsPage(type:AdDetailsTypes)
    case myPersonalCardsPage(type:AdDetailsTypes)
    case addPersonalCardPage(type:AdDetailsTypes,model:ShowPaymentModel? = nil )
    case rentalReservationPage(type:AdDetailsTypes,model:RentalReservationModel)
    case propertyOwnerInformationPage(userId:String,type:AdDetailsTypes)
    case showCardDetailsPage(type:AdDetailsTypes,model:ShowPaymentModel? = nil )

    
    @ViewBuilder
    var view: some View {
        switch self {
        case .main:
            MainPage()
        case .adsDetailsPage(let id,let type):
            AdsDetailsPage(requestID: id,navigationType: type)
        case .mainListPage(let adsArray):
            MainListPage(mainAdsList: adsArray)
        case .propertySummaryPage(let model,let type):
            PropertySummaryPage(model:model,navigationType: type)
        case .paymentMethodsPage(let type):
            PaymentMethodsPage(navigationType: type)
        case .myPersonalCardsPage(let type):
            MyPersonalCardsPage(navigationType: type)
        case .addPersonalCardPage(let type, let model):
            AddPersonalCardPage(navigationType: type,editModel: model)
        case .rentalReservationPage(let type , let model):
            RentalReservationPage(rentalReservationModel: model,navigationType: type)
       case .propertyOwnerInformationPage(let userId,let type):
            PropertyOwnerInformationPage(userID: userId,navigationType: type)
        case .showCardDetailsPage(let type, let model):
            ShowCardDetailsPage(navigationType: type,editModel: model)
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
    case createAdsSuccessPage
    case adsDetailsPage(id:String,type:AdDetailsTypes)
    case propertySummaryPage(model:SummaryModel,type:AdDetailsTypes)
    case paymentMethodsPage(type:AdDetailsTypes)
    case myPersonalCardsPage(type:AdDetailsTypes)
    case addPersonalCardPage(type:AdDetailsTypes,model:ShowPaymentModel? = nil )
    case rentalReservationPage(type:AdDetailsTypes,model:RentalReservationModel)
    case propertyOwnerInformationPage(userId:String,type:AdDetailsTypes)
    case showCardDetailsPage(type:AdDetailsTypes,model:ShowPaymentModel? = nil )
  
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
        case .createAdsSuccessPage:
            CreateAdsSuccessPage()
        case .adsDetailsPage(let id,let type):
            AdsDetailsPage(requestID: id,navigationType: type)
        case .propertySummaryPage(let model,let type):
            PropertySummaryPage(model:model,navigationType: type)
        case .paymentMethodsPage(let type):
            PaymentMethodsPage(navigationType: type)
        case .myPersonalCardsPage(let type):
            MyPersonalCardsPage(navigationType: type)
        case .addPersonalCardPage(let type, let model):
            AddPersonalCardPage(navigationType: type,editModel: model)
        case .rentalReservationPage(let type , let model):
            RentalReservationPage(rentalReservationModel: model,navigationType: type)
       case .propertyOwnerInformationPage(let userId,let type):
            PropertyOwnerInformationPage(userID: userId,navigationType: type)
        case .showCardDetailsPage(let type, let model):
            ShowCardDetailsPage(navigationType: type,editModel: model)

        }
    }
    var name: String {
        return String(reflecting: view.self)
    }
}

enum AddRequestDestination: Destination {
    case addRequest
    case addCustomerRequestsPage
    case addNewAdCategoryPage
    case addNewAdLocationPage(model:AddNewAdRequestModel)
    case propertyGalleryPage(model:AddNewAdRequestModel)
    case addNewAdsPage(model:AddNewAdRequestModel)
    case createAdsSuccessPage
    case adsDetailsPage(id:String,type:AdDetailsTypes)
    case propertySummaryPage(model:SummaryModel,type:AdDetailsTypes)
    case paymentMethodsPage(type:AdDetailsTypes)
    case myPersonalCardsPage(type:AdDetailsTypes)
    case addPersonalCardPage(type:AdDetailsTypes,model:ShowPaymentModel? = nil )
    case rentalReservationPage(type:AdDetailsTypes,model:RentalReservationModel)
    case propertyOwnerInformationPage(userId:String,type:AdDetailsTypes)
    case showCardDetailsPage(type:AdDetailsTypes,model:ShowPaymentModel? = nil )
   
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .addRequest:
            AddRequestPage()
        case .addCustomerRequestsPage:
            AddCustomerRequestsPage()
        case .addNewAdCategoryPage:
            AddNewAdCategoryPage()
        case .addNewAdLocationPage(let model):
            AddNewAdLocationPage(addNewAdRequestModel: model)
        case .propertyGalleryPage(let model):
            PropertyGalleryPage(addNewAdRequestModel: model)
        case .addNewAdsPage(let model):
            AddNewAdsPage(addNewAdRequestModel: model)
        case .createAdsSuccessPage:
            CreateAdsSuccessPage()
        case .adsDetailsPage(let id,let type):
            AdsDetailsPage(requestID: id,navigationType: type)
        case .propertySummaryPage(let model,let type):
            PropertySummaryPage(model:model,navigationType: type)
        case .paymentMethodsPage(let type):
            PaymentMethodsPage(navigationType: type)
        case .myPersonalCardsPage(let type):
            MyPersonalCardsPage(navigationType: type)
        case .addPersonalCardPage(let type, let model):
            AddPersonalCardPage(navigationType: type,editModel: model)
        case .rentalReservationPage(let type , let model):
            RentalReservationPage(rentalReservationModel: model,navigationType: type)
        case .propertyOwnerInformationPage(let userId,let type):
            PropertyOwnerInformationPage(userID: userId,navigationType: type)
        case .showCardDetailsPage(let type, let model):
            ShowCardDetailsPage(navigationType: type,editModel: model)
            
            
        }
    }

    var name: String {
        return String(reflecting: view.self)
    }
}

enum FavoritesDestination: Destination {
    case favorites
//    case message
    
    case adsDetailsPage(id:String,type:AdDetailsTypes)
    case propertySummaryPage(model:SummaryModel,type:AdDetailsTypes)
    case paymentMethodsPage(type:AdDetailsTypes)
    case myPersonalCardsPage(type:AdDetailsTypes)
    case addPersonalCardPage(type:AdDetailsTypes,model:ShowPaymentModel? = nil )
    case rentalReservationPage(type:AdDetailsTypes,model:RentalReservationModel)
    case propertyOwnerInformationPage(userId:String,type:AdDetailsTypes)
    case showCardDetailsPage(type:AdDetailsTypes,model:ShowPaymentModel? = nil )

    
    @ViewBuilder
    var view: some View {
        switch self {
//        case .message:
//            MessagesPage()
        case .favorites:
            FavoritesPage()
        case .adsDetailsPage(let id,let type):
            AdsDetailsPage(requestID: id,navigationType: type)
        case .propertySummaryPage(let model,let type):
            PropertySummaryPage(model:model,navigationType: type)
        case .paymentMethodsPage(let type):
            PaymentMethodsPage(navigationType: type)
        case .myPersonalCardsPage(let type):
            MyPersonalCardsPage(navigationType: type)
        case .addPersonalCardPage(let type, let model):
            AddPersonalCardPage(navigationType: type,editModel: model)
        case .rentalReservationPage(let type , let model):
            RentalReservationPage(rentalReservationModel: model,navigationType: type)
       case .propertyOwnerInformationPage(let userId,let type):
            PropertyOwnerInformationPage(userID: userId,navigationType: type)
        case .showCardDetailsPage(let type, let model):
            ShowCardDetailsPage(navigationType: type,editModel: model)
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}

enum MyAccountDestination: Destination {
    case myAccount
//    case favorites
    case myAdsPage
    case myRequestsPage
    case myReservationsPage
    case aboutAppPage
    case languagePage
    case contactUsPage
    case cancellationTerms
    case termsAndConditions
    case privacyPolicy(type:PoliciesAndProcedures)
    case policiesPage
    case requestDetailsPage(requestID:String)
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .myAccount:
            MyAccountPage()
//        case .favorites:
//            FavoritesPage()
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
        case .privacyPolicy(let type):
            PrivacyPolicyPage(type: type)
        case .policiesPage:
            PoliciesPage()
        case .requestDetailsPage(requestID: let requestID):
            RequestDetailsPage(requestID:requestID)
        }
    }
    
    var name: String {
        return String(reflecting: view.self)
    }
}



