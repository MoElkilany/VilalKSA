//
//  String+Extension.swift
//  VilalKSA
//
//  Created by Elkilany on 05/12/2023.
//

import SwiftUI
import RswiftResources

extension String {

    func getColor() -> Color {
        Color(self)
    }
    
    func isNumeric() -> Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
}

extension StringResource {
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self.key.description)
    }
}
