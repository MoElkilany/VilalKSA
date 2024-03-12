//
//  MyAccountModel.swift
//  VilalKSA
//
//  Created by Elkilany on 03/03/2024.
//

import Foundation

struct MyAccountResponseModel: BaseModel {
    var message: String?
    var status: Int?
    var data: MyAccountModel?
}

struct MyAccountModel: BaseModel {
    var id: Int?
    var firstName, secondName, email, phone: String?
    var isverified, isfinished: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case secondName = "second_name"
        case email, phone, isverified, isfinished
    }
}
