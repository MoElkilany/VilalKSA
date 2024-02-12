//
//  Enums.swift
//  VilalKSA
//
//  Created by Elkilany on 20/11/2023.
//

import Foundation


enum GeneralKeys: String {
    case sa = "SA"
}


enum NavigationChecker {
    case isFromSignUp
    case isForgetPassword
}

enum UserStatus {
    case none
    case isNotVerified
    case isNotCompeletProfile
    case isLogin
}

enum FontName: String {
    case cairoRegular   = "Cairo-Regular"
    case cairoBold      = "Cairo-Bold"
    case cairoLight     = "Cairo-Light"
    case cairoMedium    = "Cairo-Medium"
    case cairoSemiBold  = "Cairo-SemiBold"
    case cairoExtraBold = "Cairo-ExtraBold"
}

enum MyReservationTypes: Int, Hashable {
    case onGoing = 0
    case completed = 1
    case canceled = 2
}
