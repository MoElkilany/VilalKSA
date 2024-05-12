//
//  StateOnContentView.swift
//  VilalKSA
//
//  Created by Elkilany on 07/03/2024.
//

import SwiftUI

struct StateOnContentView<Content: View>: View {
    
    @Binding var state: AppState
    var tryAgainAction: (() -> Void)?
    var stateError: String
    var titlePage: LocalizedStringKey? = ""
    var content: Content
   
    
    init(state: Binding<AppState>, tryAgainAction: ( () -> Void)? = nil, stateError: String, @ViewBuilder content: () -> Content,titlePage:LocalizedStringKey = "" ) {
        self._state = state
        self.tryAgainAction = tryAgainAction
        self.content = content()
        self.stateError = stateError
        self.titlePage = titlePage
    }
    
    
    var body: some View {

        VStack{
            TextBold16(textKey: titlePage ?? "", textColor: R.color.colorPrimary.name.getColor())
                .padding(.top,60)
        ZStack{
            content
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
                .padding(.bottom,20)
            
            VStack {
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
        .background(.white)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
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
    
    
    var errorWithTitle: Bool {
        state == .errorWithTitle
    }
}
