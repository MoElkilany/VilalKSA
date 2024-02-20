//
//  AddNewAdRequestModel.swift
//  VilalKSA
//
//  Created by Elkilany on 11/02/2024.
//

import Foundation

struct AddNewAdRequestModel: BaseModel {
    var categoryAdID: String?
    var addLat: String?
    var addLng: String?
    var addAddress: String?
    var images: [Data]?
    var videosData: Data?

}
