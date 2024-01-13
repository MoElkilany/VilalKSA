//
//  LoginModel.swift
//  VilalKSA
//
//  Created by Elkilany on 05/01/2024.
//

import Foundation

struct LoginRequest: BaseModel {
    var phone: String?
    var password: String?
}

struct LoginResponse: BaseModel {
    var message: String?
    var status: Int?
    var data: LoginValue?
}

struct LoginValue: BaseModel {
    var id: Int?
    var firstName, secondName, email, phone: String?
    var isverified, isfinished: Bool?
    var token: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case secondName = "second_name"
        case email, phone, isverified, isfinished, token
    }
}
