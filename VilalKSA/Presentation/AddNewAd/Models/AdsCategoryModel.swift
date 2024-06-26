//
//  AdsCategoryModel.swift
//  VilalKSA
//
//  Created by Elkilany on 11/02/2024.
//

import Foundation
struct AdsCategoryModel: BaseModel {
    var message: String?
    var status: Int?
    var data: [AdsCategoryResponse]?
}

struct AdsCategoryResponse: BaseModel,Identifiable {
    var id: Int?
    var name: String?
    var icon: String?
    var status: String?
}
