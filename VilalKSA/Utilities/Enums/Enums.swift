//
//  Enums.swift
//  VilalKSA
//
//  Created by Elkilany on 20/11/2023.
//

import Foundation

enum TabBarItemType: String {
    case TabBarHome
    case TabBarCouncils
    case TabBarCommittees
    case TabBarMore
}


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
