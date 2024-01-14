//
//  PopupPresent.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI

class PopupPresent: ObservableObject {
        
    @Published var isPopupPresented = false
    @Published var isSheetPresented = false
    @Published var councilsScrollToTop = false
    @Published var homeScrollToTop = false
    @Published var committeesScrollToTop = false
    
    @Published var popupView: GenericView = GenericView {
        AnyView(VStack{})
    }
}

struct GenericView<Content: View>: View {
    // Define the content as a property of type Content
    @ViewBuilder
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        // Use the content as a child view inside a VStack
        VStack(content: content)
    }
}
