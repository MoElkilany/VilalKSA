//
//  AdsInterfaceModel.swift
//  VilalKSA
//
//  Created by Elkilany on 17/02/2024.
//

import Foundation
struct LookUpResponse: BaseModel {
    let message: String?
    let status: Int?
    let data: [LookUpModel]?
}

// MARK: - Datum
struct LookUpModel: BaseModel, Identifiable {
    let id: Int?
    let name: String?
    var isSelected: Bool? = false
  
}



