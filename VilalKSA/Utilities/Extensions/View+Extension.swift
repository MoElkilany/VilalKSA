//
//  View+Extension.swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//


import SwiftUI

typealias EmptyActionClosure = (() -> ())

extension View {
    
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
    
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
    
    
    
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
    func customCardStyle(corner:CGFloat? = 0 ) -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(RoundedRectangle(cornerRadius: corner ?? 0 )
                    .fill(Color.white)
                    .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
        }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
