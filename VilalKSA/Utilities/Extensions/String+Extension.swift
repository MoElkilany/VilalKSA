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
}


extension StringResource {
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self.key.description)
    }
}
