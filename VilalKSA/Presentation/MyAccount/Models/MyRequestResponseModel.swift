//
//  MyRequestResponseModel.swift
//  VilalKSA
//
//  Created by Elkilany on 05/03/2024.
//
import Foundation

struct MyRequestResponseModel: BaseModel {
    var message: String?
    var status: Int?
    var data: [MyRequestModel]?
}

// MARK: - Datum
struct MyRequestModel: BaseModel {
    var id: Int?
    var name, category: String?
    var image: String?
    var price: String?
    var rental: String?
    var favourite: Bool?
    var room: String?
    var space: Double?
    var rate: Int?
    var lat, lon, estateSpace, address: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, category, image, price, rental, favourite, room, space, rate, lat, lon
        case estateSpace = "estate_space"
        case address
        case createdAt = "created_at"
    }
}


