//
//  VerificationCodeModel.swift
//  VilalKSA
//
//  Created by Elkilany on 09/01/2024.
//

import Foundation

struct VerificationCodeRequest: BaseModel {
    var code: String?
    var phone: String?
}
