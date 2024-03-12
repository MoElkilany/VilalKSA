//
//  FavoriteModel.swift
//  VilalKSA
//
//  Created by Elkilany on 03/03/2024.
//

import Foundation
struct FavoriteResponseModel: BaseModel {
    var message: String?
    var status: Int?
    var data: [FavoriteModel]?
}

struct FavoriteModel: BaseModel {
    var id: Int?
    var name, category,address,lat,lon: String?
    var image: String?
    var price, rental: String?
    var favourite: Bool?
    var room: String?
    var space, rate: Int?
}


struct BaseResponseModel: BaseModel {
    var message: String?
    var status: Int?

}
