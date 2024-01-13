//
//  Color+Extension.swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//

import SwiftUI

//extension Color {
//    convenience init(hex: String) {
//        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
//
//        var rgb: UInt64 = 0
//
//        Scanner(string: hexSanitized).scanHexInt64(&rgb)
//
//        self.init(
//            red: Double((rgb >> 16) & 0xFF) / 255.0,
//            green: Double((rgb >> 8) & 0xFF) / 255.0,
//            blue: Double(rgb & 0xFF) / 255.0, alpha: 0.0
//        )
//    }
//}


//extension Color {
//    convenience init(hex: String) {
//        let scanner = Scanner(string: hex)
//        _ = scanner.scanString("#") // Optional: Handle the hash mark
//
//        var rgbValue: UInt64 = 0
//        scanner.scanHexInt64(&rgbValue)
//        
//        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
//        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
//        let b = Double(rgbValue & 0x0000FF) / 255.0
//
//        self.init(red: r, green: g, blue: b, alpha: 1)
//    }
//}


//extension Color {
//    convenience init(hex: String) {
//        let scanner = Scanner(string: hex)
//        var rgbValue: UInt64 = 0
//        scanner.scanHexInt64(&rgbValue)
//
//        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
//        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
//        let blue = Double(rgbValue & 0x0000FF) / 255.0
//
//        self.init(red: red, green: green, blue: blue, alpha: 1)
//    }
//
//    static var customPrimaryColor: Color {
//        let currentStyle = UIScreen.main.traitCollection.userInterfaceStyle
//        return currentStyle == .light ? Color(red: 0.1, green: 0.1, blue: 0.1, alpha: 1) : Color(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
//    }
//}

