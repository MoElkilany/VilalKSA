//
//  ChangePasswordModel.swift
//  VilalKSA
//
//  Created by Elkilany on 11/01/2024.
//

import Foundation
struct ChangePasswordRequest: BaseModel {
    
    var password: String?
    var confirmPassword: String?

    enum CodingKeys: String, CodingKey {
        case password
        case confirmPassword = "confirm_password"
    }
}
