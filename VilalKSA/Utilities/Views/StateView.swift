//
//  StateViewSwiftUI.swift
//  Production-with-intune
//
//  Created by Michael on 23/10/2022.
//

import SwiftUI

enum AppState {
    case searchEmptyResults
    case empty
    case loading
    case error
    case noData
    case success
    case errorWithTitle
}

typealias ActionClosure = (() -> ())

struct StateView<Content: View>: View {
    
    @Binding var state: AppState
    var action: (() -> Void)?
    var clearSearchAction: (() -> ())?
    var title: String? = nil
    var localizeTitle: LocalizedStringKey? = nil
    var description: String? = nil
    var content: Content
    var padding: Double

    init(state: Binding<AppState> , title: String? = nil, localizeTitle: LocalizedStringKey? = nil, description: String? = nil, padding: Double = 20,action: ActionClosure?, clearSearchAction: EmptyActionClosure? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._state =  state
        self.title = title
        self.localizeTitle = localizeTitle
        self.description = description
        self.action = action
        self.clearSearchAction = clearSearchAction
        self.padding = padding
    }
    
    
    var body: some View {
        ZStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
            VStack {
                if self.state == .loading {
                    VStack {
                        Loader()
                        Text("Loading")
                    }
                    .background(SwiftUI.Color.white)
                    .ignoresSafeArea()
                }
                if tryAgian {
                    StateTryAgainView(title: title, description: description,localizeTitle: localizeTitle, action: makeAction)
                }
                if noData {
                    Text("NoResultsFound")
                }
                
                if emptySearchResults {
                    NoDataView(action: searchAction)
                }
                
            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(self.state == .success ? Color.clear : Color.white)
//            .cornerRadius(20)
//            .opacity(stateViewSwiftUIOpacity)
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(self.state == .success ? SwiftUI.Color.red : SwiftUI.Color.white)
//            .background(Color : self.state == .success ? ColorName.color342643.color : ColorName.color342643.color)

            
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
        state == .error
    }
    
    var noData: Bool {
        state == .noData
    }
    
    var emptySearchResults: Bool {
        state == .searchEmptyResults
    }
    
    func makeAction() {
        self.state = .loading
        self.action?()
    }
    
    func searchAction() {
        self.state = .loading
        self.clearSearchAction? ()
    }
}




struct StateTryAgainView: View {
    var title: String?
    var description: String?
    var localizeTitle: LocalizedStringKey? = nil
    var action: EmptyActionClosure
    
    var body: some View {
        VStack {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 15, height: 15)
            if title != nil {
                Text("description")
//                TextSubTitleFont(textKey: title?.localizedKey)
                    .padding(.top, 20)
            } else {
                Text("description")
//                TextSubTitleFont(textKey: localizeTitle)
                    .padding(.top, 20)
            }
            Text("description")
//            TextSubTitleFont(text:  description ?? "")
            
            Button(action: action) {
                Text("TryAgain")
//                TextTitleFont(textKey:  LocalizationKeys.TryAgain.localizedKey , color: Color.white)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 12)
                    .background(SwiftUI.Color.red)
                    .padding(.top, -4)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 15)
        }
    }
}


struct NoDataView: View {
    var action: EmptyActionClosure
    
    var body: some View {
        VStack {
//                TextSubTitleFont(textKey:  LocalizationKeys.NoResultsFound.localizedKey)
            Text("NoResultsFound")

            Image(systemName: "square.and.arrow.up")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 15, height: 15)
        }
    }
}

