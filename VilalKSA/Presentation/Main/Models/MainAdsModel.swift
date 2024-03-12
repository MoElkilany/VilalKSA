//
//  MainAdsModel.swift
//  VilalKSA
//
//  Created by Elkilany on 24/02/2024.
//

import Foundation

struct MainAdsModel: BaseModel {
    var message: String?
    var status: Int?
    var data: [MainAdsResponse]?
}

// MARK: - Datum
struct MainAdsResponse: BaseModel,Identifiable {
    var isSelected: Bool?
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
        case id, name, category, image, price, rental, favourite, room, space, rate, lat, lon, address
        case estateSpace = "estate_space"
        case createdAt = "created_at"
        case isSelected = "is_selected"
    }
}


