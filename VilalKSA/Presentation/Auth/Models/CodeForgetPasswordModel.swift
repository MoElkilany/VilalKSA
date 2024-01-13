//
//  CodeForgetPasswordModel.swift
//  VilalKSA
//
//  Created by Elkilany on 11/01/2024.
//

import Foundation
struct CodeForgetPasswordRequest: BaseModel {
    var phone: String?
    var code: String?
}
