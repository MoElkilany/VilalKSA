//
//  MainAdRequest.swift
//  VilalKSA
//
//  Created by Elkilany on 24/02/2024.
//

import Foundation
struct MainAdRequest: BaseModel {
    var categoryID: String?
    var lat: String?
    var lon: String?
    var price: String?
    var room: String?
    var space: String?
    var bathrooms: String?
    var lounges: String?
    var sort: String?
}
