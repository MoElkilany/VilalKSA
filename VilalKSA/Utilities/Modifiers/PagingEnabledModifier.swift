//
//  PagingEnabledModifier.swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//

import SwiftUI

extension ScrollView {
    func pagingEnabled(_ enabled: Bool) -> some View {
        return modifier(PagingEnabledModifier(enabled: enabled))
    }
}

struct PagingEnabledModifier: ViewModifier {
    let enabled: Bool
    
    init(enabled: Bool) {
        self.enabled = enabled
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            UIScrollView.appearance().isPagingEnabled = self.enabled
        }
    }
}
