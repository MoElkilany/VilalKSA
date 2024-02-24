//
//  CustomerRequestsModel.swift
//  VilalKSA
//
//  Created by Elkilany on 30/01/2024.
//

import Foundation

struct CustomerRequestsModel: BaseModel {
    var message: String?
    var status: Int?
    var data: [CustomerRequestsValueModel]?
}


struct CustomerRequestsValueModel: BaseModel {
    var id: Int?
    var name, category, lat,address, lon ,created_at,rental,resident: String?
    var price: CustomerRequestsPrice?
}

struct CustomerRequestsPrice: BaseModel {
    var from, to: String?
}



struct CustomerRequestsDetailsModel: BaseModel {
    var message: String?
    var status: Int?
    var data: CustomerRequestsDetailsValue?
}

struct CustomerRequestsDetailsValue: BaseModel {
    var main: Main?
    var owner: Owner?
    var details: [Detail]?
    var map: Map?
    var properites: [ProperitesModel]?
}

struct Detail: BaseModel {
    var name, value: String?
}

struct Main: BaseModel {
    var id: Int?
    var name, category: String?
    var price: Price?
    var rental, createdAt,estateSpace,resident: String?

    enum CodingKeys: String, CodingKey {
        case id, name, category, price, rental,resident
        case createdAt = "created_at"
        case estateSpace = "estate_space"
    }
}

struct Price: BaseModel {
    var from, to: String?
}

struct Map: BaseModel {
    var lat, lon, address: String?
}

struct Owner: BaseModel {
    var id: Int?
    var name: String?
    var image: String?
    var phone: String?
    var whatsapp: String?
    var date: String?
}

struct ProperitesModel: BaseModel {
    var id: Int?
    var icon: String?
    var name: String?
}
