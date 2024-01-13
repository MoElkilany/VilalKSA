//
//  AppUtility.swift
//  VilalKSA
//
//  Created by Elkilany on 04/01/2024.
//

import Foundation
import UIKit

public class AppUtility: NSObject {
    
    static func getUserToken() -> String {
        return ""
    }
    
    static func getUuid()-> String{
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString else {return ""}
        
        return uuid
    }
    
    static func decodeStringJsonToSwiftModel<T: BaseModel>(jsonString: String, model: T.Type) -> T? {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(model.self, from: data)
    }
    
}
