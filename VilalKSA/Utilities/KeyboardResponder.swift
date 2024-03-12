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
    var keyboardShow = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink(receiveCompletion: { _ in }, receiveValue: { notification in
                self.currentHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            })
            .store(in: &keyboardShow)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).sink(receiveCompletion: { _ in }, receiveValue: { _ in
            self.currentHeight = 0
        })
        .store(in: &keyboardShow)

    }
}

