//
//  AddPaymentModel.swift
//  VilalKSA
//
//  Created by Elkilany on 01/04/2024.
//

import Foundation
struct AddPaymentRequestModel: BaseModel {
    var name: String
    var number: String
    var cvv: String
    var date: String
}

struct PaymentsResponseModel: BaseModel {
    var message: String?
    var status: Int?
    var data: [PaymentsModel]?
}

struct PaymentsModel: BaseModel {
    var id: Int?
    var name, number,cvv,date: String?
}
