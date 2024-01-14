//
//  ServicesModel.swift
//  VilalKSA
//
//  Created by Elkilany on 14/01/2024.
//

import Foundation

struct ServicesModel: BaseModel {
    var message: String?
    var status: Int?
    var data: [ServicesResponse]?
}

struct ServicesResponse: BaseModel {
    var id: Int?
    var name: String?
    var icon: String?
    var status: Bool?
}
