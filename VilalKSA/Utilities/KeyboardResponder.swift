//
//  KeyboardResponder.swift
//  VilalKSA
//
//  Created by Elkilany on 18/02/2024.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    
    var keyboardShow: AnyCancellable?
    var keyboardHide: AnyCancellable?
    
    init() {
        keyboardShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            }
            .assign(to: \.currentHeight, on: self)
        
        keyboardHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in 0 }
            .assign(to: \.currentHeight, on: self)
    }
}
