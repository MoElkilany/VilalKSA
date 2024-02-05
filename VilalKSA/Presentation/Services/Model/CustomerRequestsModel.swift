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


struct CustomerRequestsDetailsModel: BaseModel {
    var message: String?
    var status: Int?
    var data: CustomerRequestsValueModel?
}

// MARK: - Datum
struct CustomerRequestsValueModel: BaseModel {
    var id: Int?
    var name, category, lat, lon: String?
    var price: CustomerRequestsPrice?
}

// MARK: - Price
struct CustomerRequestsPrice: BaseModel {
    var from, to: String?
}
