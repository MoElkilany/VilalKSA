//
//  View+Extension.swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//


import SwiftUI

typealias EmptyActionClosure = (() -> ())

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
    func isAvailableToAddPullToRefresh(action: EmptyActionClosure?) -> some View{
        if #available(iOS 15.0, *) {
            return  self.refreshable {
                action? ()
            }
        }  else {
            return self
        }
    }
    
    func shadowedStyle() -> some View {
        self
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
    }
    
    
}
