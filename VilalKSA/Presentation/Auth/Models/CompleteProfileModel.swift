//
//  CompleteProfileModel.swift
//  VilalKSA
//
//  Created by Elkilany on 09/01/2024.
//

import Foundation

struct CompleteProfileModelRequest: BaseModel {
    
      var firstName: String?
      var secondName: String?
      var email: String?
      var password: String?
      var confirmPassword: String?
      var platform: String? = "ios"
      var fcmToken: String? = "testtt"
      
      enum CodingKeys: String, CodingKey {
          case firstName = "first_name"
          case secondName = "second_name"
          case email
          case password
          case confirmPassword = "confirm_password"
          case platform
          case fcmToken = "fcm_token"
      }
    
}
