//
//  TodayAdsModel.swift
//  VilalKSA
//
//  Created by Elkilany on 04/02/2024.
//

import Foundation

struct TodayAdsModel: Codable {
    var message: String?
    var status: Int?
    var data: [todayAdsValue]?
}

// MARK: - Datum
struct todayAdsValue: Codable {
    var id: Int?
    var name, category: String?
    var image: String?
    var price, rental: String?
    var favourite: Bool?
    var room: String?
    var space: Double?
    var rate: Int?
    var lat, lon, address, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, category, image, price, rental, favourite, room, space, rate, lat, lon, address
        case createdAt = "created_at"
    }
}
