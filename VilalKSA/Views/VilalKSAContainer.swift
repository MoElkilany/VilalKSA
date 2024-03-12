//
//  StateViewSwiftUI.swift
//  Production-with-intune
//
//  Created by Michael on 23/10/2022.
//

import SwiftUI
import LanguageManagerSwiftUI

enum AppState {
    case empty
    case loading
    case error
    case noData
    case success
    case errorWithTitle
    case serverError
}

typealias ActionClosure = (() -> ())

struct VilalKSAContainer<Content: View>: View {
    
    @StateObject private var keyboard = KeyboardResponder()
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @EnvironmentObject var languageSettings: LanguageSettings
    
    @Binding var state: AppState
    var tryAgainAction: (() -> Void)?
    var backAction: (() -> Void)? = nil
    var titlePage: LocalizedStringKey? = nil
    var description: String? = nil
    var content: Content
    var padding: Double
    var haveAnotherButton: Bool? = nil
    var iconButton: String? = nil
    var buttonAction: (() -> Void)? = nil
    var stateError: String
    
    
    init(state: Binding<AppState> , titlePage: LocalizedStringKey? = nil, description: String? = nil, padding: Double = 20,stateError:String = "-",tryAgainAction: ActionClosure? = nil, backAction:ActionClosure?, haveAnotherButton:Bool? = nil ,buttonAction:ActionClosure? = nil,iconButton: String? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._state =  state
        self.titlePage = titlePage
        self.description = description
        self.tryAgainAction = tryAgainAction
        self.padding = padding
        self.backAction = backAction
        self.buttonAction = buttonAction
        self.iconButton = iconButton
        self.haveAnotherButton = haveAnotherButton
        self.stateError = stateError
    }
    
    
    var body: some View {
        
        VStack{
            VilalNavigationView(languageSettings: _languageSettings, titlePage: self.titlePage, backAction: self.backAction, haveAnotherButton: self.haveAnotherButton ?? false, icon:  self.iconButton, buttonAction:  self.buttonAction)
            
                .padding(.top,60)
            ZStack {
                content
                    .padding(.bottom, keyboard.currentHeight + 20 )
                    .environmentObject(networkMonitor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .ignoresSafeArea()
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                VStack {
                    
                    if !networkMonitor.isConnected {
                        NetworkUnavailableView()
                    }
                    
                    if self.state == .loading {
                        VStack {
                            Loader()
                            TextMeduim12(textKey: R.string.localizable.loading.localized, textColor: R.color.colorPrimary.name.getColor())
                        }
                        .background(SwiftUI.Color.white)
                        .ignoresSafeArea()
                    }
                    
                    if tryAgian {
                        StateTryAgainView(action: makeAction)
                    }
                    
                    if noData {
                        NoDataView()
                    }
                    
                    if errorWithTitle{
                        ErrorWithTitle(error: stateError)
                    }
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(self.state == .success ? SwiftUI.Color.red : SwiftUI.Color.white)
                .cornerRadius(20)
                .opacity(stateViewSwiftUIOpacity)
                
                HStack {
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var stateViewSwiftUIOpacity: Double {
        return state == .success ? 0: 1
    }
    
    var startLoading: Bool {
        state == .loading
    }
    
    var tryAgian: Bool {
        state == .serverError
    }
    
    var noData: Bool {
        state == .noData
    }
    
    var serverError: Bool {
        state == .serverError
    }
    
    func makeAction() {
        
        self.tryAgainAction?()
    }
    
    func searchAction() {
        self.state = .loading
        //        self.clearSearchAction? ()
    }
    
    var errorWithTitle: Bool {
        state == .errorWithTitle
    }
    
}




struct StateTryAgainView: View {
    var action: EmptyActionClosure
    
    var body: some View {
        VStack {
            Image(R.image.noInternet.name)
                .frame(width: 30, height: 30)
                .padding(.bottom,30)
            
            TextBold20(textKey: R.string.localizable.something_Wrong.localized, textColor: R.color.colorPrimary.name.getColor())
            TextRegular16(textKey: R.string.localizable.please_Try_Again.localized, textColor: R.color.color7A869A.name.getColor())
                .multilineTextAlignment(.center)
            
            DefaultButton(title:  R.string.localizable.try_Again.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                action()
            }, fontWeight: .bold)
            .padding(.horizontal, 15)
        }
    }
}

//#Preview{
//    StateTryAgainView(action: {
//        print("tets")
//    })
//}

struct NoDataView: View {
    
    
    var body: some View {
        VStack() {
            
            
            Image(R.image.noResult.name)
                .frame(width: 30, height: 30)
                .padding(.bottom,30)
            
            TextBold20(textKey: R.string.localizable.empty_No_Result_Found.localized, textColor: R.color.colorPrimary.name.getColor())
            
            TextRegular16(textKey: R.string.localizable.empty_No_Result_Found_Description.localized, textColor: R.color.color7A869A.name.getColor())
                .multilineTextAlignment(.center)
            
        }
    }
}



struct NetworkUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "No Internet Connection",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
}


struct VilalNavigationView: View {
    @EnvironmentObject var languageSettings: LanguageSettings
    var titlePage:LocalizedStringKey?
    var backAction: (() -> Void)?
    var haveAnotherButton: Bool = false
    var icon:String?
    var buttonAction: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: .center){
            TextBold16(textKey: titlePage ?? "", textColor: R.color.colorPrimary.name.getColor())
            if backAction != nil {
                HStack {
                    Button(action: backAction!) {
                        Image(languageSettings.selectedLanguage == .ar ? R.image.back_button_right_icon.name : R.image.back_button_left_icon.name )
                            .resizable()
                            .frame(width: 25, height: 15)
                    }
                    Spacer()
                    
                    if haveAnotherButton == true  {
                        Button(action:buttonAction! ) {
                            Image(icon ?? "" )
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                }
                .padding(.horizontal,25)
            }
        }
    }
}



struct ErrorWithTitle: View {
    let error: String?
    var body: some View {
        VStack {
            Image(R.image.noInternet.name)
                .frame(width: 30, height: 30)
                .padding(.bottom,30)
                .padding(.vertical,12)
            
            TextBold20(textKey: R.string.localizable.something_Wrong.localized, textColor: R.color.colorPrimary.name.getColor())
                .padding(.vertical,12)
            
            TextRegular16(textKey: R.string.localizable.empty_No_Result_Found_Description.localized, textColor: R.color.color7A869A.name.getColor())
            
                .multilineTextAlignment(.center)
            
                .padding(.horizontal, 15)
        }
    }
}

#Preview{
    VilalNavigationView(titlePage: "test 1", backAction: {
        
    }, haveAnotherButton: false , icon:  R.image.back_button_left_icon.name) {
        
    }
}


