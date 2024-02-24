//
//  AdDetailsModel.swift
//  VilalKSA
//
//  Created by Elkilany on 23/02/2024.
//

import Foundation

struct AdDetailsModel: BaseModel {
    var message: String?
    var status: Int?
    var data: AdDetailsValue?
}

struct AdDetailsValue: BaseModel {
    var description: String?
    var images     : [String]?
    var main       : MainAdDetails?
    var owner      : Owner?
    var details     : [Detail]?
    var map         : Map?
    var properites  : [ProperitesModel]?
    var similarAds : [SimilarAd]?
    
    enum CodingKeys: String, CodingKey {
        case description, images, main, owner, details, map, properites
        case similarAds = "similar_ads"
       
    }
    
}


struct MainAdDetails: BaseModel {
    var id: Int?
       var name, category, price, rental: String?
       var resident: String?
       var favourite: Bool?
       var rate: Int?
       var estateSpace, createdAt: String?

       enum CodingKeys: String, CodingKey {
           case id, name, category, price, rental, resident, favourite, rate
           case estateSpace = "estate_space"
           case createdAt = "created_at"
       }
}

struct SimilarAd: BaseModel {
    var id: Int?
    var name, category: String?
    var image: String?
    var price, rental: String?
    var favourite: Bool?
    var room: String?
    var space, rate: Int?
    var lat, lon, estateSpace, address: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, category, image, price, rental, favourite, room, space, rate, lat, lon
        case estateSpace = "estate_space"
        case address
        case createdAt = "created_at"
    }
}
