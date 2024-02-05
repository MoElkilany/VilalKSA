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
    
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @EnvironmentObject var languageSettings: LanguageSettings
    
    @Binding var state: AppState
    var tryAgainAction: (() -> Void)?
    var backAction: (() -> Void)? = nil
    var titlePage: LocalizedStringKey? = nil
    var description: String? = nil
    var content: Content
    var padding: Double
    
    init(state: Binding<AppState> , titlePage: LocalizedStringKey? = nil, description: String? = nil, padding: Double = 20,tryAgainAction: ActionClosure? = nil, backAction:ActionClosure?, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._state =  state
        self.titlePage = titlePage
        
        self.description = description
        self.tryAgainAction = tryAgainAction
        self.padding = padding
        self.backAction = backAction
    }
    
    
    var body: some View {
        ZStack {

            VStack{
                ZStack(alignment: .center){
                    TextBold16(text: titlePage ?? "", textColor: R.color.colorPrimary.name.getColor())

                    if backAction != nil {
                        HStack {
                            Button(action: backAction!) {
                                Image(languageSettings.selectedLanguage == .ar ? R.image.back_button_right_icon.name : R.image.back_button_left_icon.name )
                                    .resizable()
                                    .frame(width: 30, height: 20)
                            }
                            Spacer()
                            
                        }
                        .padding(.horizontal,25)
                    }
                }
                .padding(.top,60)
                content
                    .environmentObject(networkMonitor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .ignoresSafeArea()
            }
            
            VStack {
                
                if !networkMonitor.isConnected {
                    NetworkUnavailableView()
                }
                
                if self.state == .loading {
                    VStack {
                        Loader()
                        TextMeduim12(text: R.string.localizable.loading.localized, textColor: R.color.colorPrimary.name.getColor())
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
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(self.state == .success ? SwiftUI.Color.red : SwiftUI.Color.white)
            .cornerRadius(20)
            .opacity(stateViewSwiftUIOpacity)
            
            HStack {
                Spacer()
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
}




struct StateTryAgainView: View {
    var action: EmptyActionClosure
    
    var body: some View {
        VStack {
            Image(R.image.noInternet.name)
                .frame(width: 30, height: 30)
                .padding(.bottom,30)
            
            TextBold20(text: R.string.localizable.something_Wrong.localized, textColor: R.color.colorPrimary.name.getColor())
            TextRegular16(text: R.string.localizable.please_Try_Again.localized, textColor: R.color.color7A869A.name.getColor())
                .multilineTextAlignment(.center)
            
            DefaultButton(title:  R.string.localizable.try_Again.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                action()
            }, fontWeight: .bold)
            .padding(.horizontal, 15)
        }
    }
}

#Preview{
    StateTryAgainView(action: {
        print("tets")
    })
}

struct NoDataView: View {
    
    
    var body: some View {
        VStack() {
            
            
            Image(R.image.noResult.name)
                .frame(width: 30, height: 30)
                .padding(.bottom,30)
            
            TextBold20(text: R.string.localizable.empty_No_Result_Found.localized, textColor: R.color.colorPrimary.name.getColor())
            
            TextRegular16(text: R.string.localizable.empty_No_Result_Found_Description.localized, textColor: R.color.color7A869A.name.getColor())
                .multilineTextAlignment(.center)
            
        }
    }
}

//#Preview{
//    NoDataView()
//}




struct NetworkUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "No Internet Connection",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
}
#Preview{
    NetworkUnavailableView()
}
