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
    
    func isValidSaudiNumber() -> Bool {
        let saudiNumberRegex = #"^((\+|00)?966|0)?5[0-9]{8}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", saudiNumberRegex)
        return predicate.evaluate(with: self)
    }
    
    func isValidEgyptionNumber() -> Bool {
        let egyptNumberRegex = #"^01[0-2]{1}[0-9]{8}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", egyptNumberRegex)
        return predicate.evaluate(with: self)
    }
    
    
    func isValidCardNumber() -> Bool {
        let cardNumberRegex = #"^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9]{2})[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])?[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$"#
        let isValid = NSPredicate(format: "SELF MATCHES %@", cardNumberRegex)
        return isValid.evaluate(with: self)
    }
    
    
    func isValidateExpiryDate() -> Bool {
        let expiryDateRegex = #"^(0[1-9]|1[0-2])\/[0-9]{2}$"#
        let isValid = NSPredicate(format: "SELF MATCHES %@", expiryDateRegex)
        return isValid.evaluate(with: self)
    }
    
    
}

extension StringResource {
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self.key.description)
    }
}
