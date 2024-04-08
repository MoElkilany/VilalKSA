//
//  PropertyOwnerModel.swift
//  VilalKSA
//
//  Created by Elkilany on 31/03/2024.
//

struct PropertyOwnerModel: Codable {
    var message: String?
    var status: Int?
    var data: PropertyOwnerData?
}

// MARK: - DataClass
struct  PropertyOwnerData: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var phone: String?
    var whatsapp: String?
    var email, join, active, rate: String?
    var ads: [MyAdsModel]?
}

