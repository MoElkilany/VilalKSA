//
//  CreateNewAdsRequestModel.swift
//  VilalKSA
//
//  Created by Elkilany on 17/02/2024.
//

import Foundation

struct CreateNewAdsRequestModel: BaseModel {
    
    let typeId: String?
    let categoryId: String?
    let lat: String?
    let lon: String?
    let interfaceId: String?
    let room: String?
    let lounges: String?
    let bathrooms: String?
    let space: String? // عرض الشارع
    let estateSpace: String? // مساحة العقار
    let floorNumber: String?
    let ageRealEstate: String?
    let airConditioners: String?
    let specialSurface: String?
    let villa: String?
    let twoEntrances: String?
    let privateEntrance: String?
    let info: String?
    let furnished: String?
    let kitchen: String?
    let appendix: String?
    let carEntrance: String?
    let elevator: String?
    
    let priceFrom: String?
    let priceTo: String?
    let rentalperiodID: String?
    let residentID:String?
    

    enum CodingKeys: String, CodingKey {
        case typeId = "type_id"
        case categoryId = "category_id"
        case lat
        case lon
        case interfaceId = "interface_id"
        case room
        case lounges
        case bathrooms
        case space
        case estateSpace = "estate_space"
        case floorNumber = "floor_number"
        case ageRealEstate = "age_realEstate"
        case airConditioners = "air_conditioners"
        case specialSurface = "special_surface"
        case villa
        case twoEntrances = "two_entrances"
        case privateEntrance = "private_entrance"
        case info
        case furnished
        case kitchen
        case appendix
        case carEntrance = "car_entrance"
        case elevator
        case priceFrom = "price_from"
        case priceTo = "price_to"
        case rentalperiodID = "rentalperiod_id"
        case residentID = "resident_id"
    }
}



struct CreateNewAdsResponseModel: BaseModel {
    let message: String?
    let status: Int?
}



struct CreateNewAdsRequestModel2: BaseModel {
    let type_id: String?
    let room: String?
    
    let price_from: String?
    let price_to: String?
    let lounges: String?
    let bathrooms: String?
    let floor_number: String?
    let age_realEstate: String?

    let lat: String?
    let lon: String?
    let category_id: String?
    
    
    let interface_id: String?
    let rentalperiod_id: String?
    let resident_id: String?
    let air_conditioners: String?
    let special_surface: String?
    let villa: String?
    let two_entrances: String?
    let private_entrance: String?
    
    
    
    let price: String?
    let furnished: String?
    let kitchen: String?
    let appendix: String?
    let car_entrance: String?
    let elevator: String?
    let info: String?
    let space: String?
    let water_availability: String?
    let estate_space: String?
}
