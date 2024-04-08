//
//  Converter.swift
//  VilalKSA
//
//  Created by Elkilany on 17/02/2024.
//

import Foundation
import SwiftUI

public typealias DictionryAny = [String: Any]
public typealias Dictionary = [String: String]

class Convert {
    
    static func convertAnyToData(_ value: Any) -> Data? {
        if let value = value as? String {
            return Data(value.utf8)
        } else if let value = value as? Int {
            return withUnsafeBytes(of: value) { Data($0) }
        } else if let value = value as? Double {
            return withUnsafeBytes(of: value) { Data($0) }
        } else if let value = value as? DictionryAny {
            return try? JSONSerialization.data(withJSONObject: value, options: [])
        } else if let value = value as? Array<Any> {
            return try? JSONSerialization.data(withJSONObject: value, options: [])
        } else if let value = value as? Data {
            return value
        }
        // Add more types as needed
        
        return nil // or throw an error if you prefer
    }
    
    static func convertDataToString(data: Data) -> String? {
        return String(data: data, encoding: .utf8)
    }
    
    static func dataToStrJSON(data: Data) -> String? {
        do {
            // Deserialize the JSON data into a JSON object
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            // Re-serialize the JSON object to Data with pretty printing
            let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            
            // Convert the pretty-printed JSON data back into a String
            if let prettyPrintedString = String(data: prettyJsonData, encoding: .utf8) {
                return prettyPrintedString
            }
        } catch {
            print("Error converting JSON data to string: \(error)")
        }
        
        // Return nil in case of failure
        return nil
    }

    
    static func convertDateFormat(dateStr: String, from oldFormat: String, to newFormat: String, currentLang:String?) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat
        dateFormatter.locale = Locale(identifier: currentLang ?? "en" )
        guard let date = dateFormatter.date(from: dateStr) else { return nil }
        
        dateFormatter.dateFormat = newFormat
        let newDateString = dateFormatter.string(from: date)
        
        return newDateString
    }
    
    static func convertDateToSlashes(dateStr: String) -> String? {
        return convertDateFormat(dateStr: dateStr, from: Formats.veryLongFormat.rawValue, to: Formats.DateWithSlashes.rawValue, currentLang: nil)
    }
    
    static func bindingDateToString(date: Binding<Date>) -> Binding<String> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Formats.DateWithSlashes.rawValue
        return Binding<String>(
            get: {
                return dateFormatter.string(from: date.wrappedValue ?? Date())
            },
            set: { newValue in
                date.wrappedValue = dateFormatter.date(from: newValue) ?? Date()
            }
        )
    }
    

    
    
    static func time12ToTime24(inputTime: String)->String {
        
        var finalTime = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "h:mm a"
        
        if let date = inputFormatter.date(from: inputTime) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            let timeIn24HourFormat = outputFormatter.string(from: date)
            finalTime = timeIn24HourFormat
        }
        
        return finalTime
    }
    
    
    static  func imageToData(images:[UIImage])-> [Data]{
        var arrayOfData: [Data] = []
        for image in images {
            if let imageData = image.pngData() {
                arrayOfData.append(imageData)
            }
        }
        return arrayOfData
    }
    
    static func dataToImage(data: [Data]) -> [UIImage] {
        var images: [UIImage] = []
        for imageData in data {
            if let image = UIImage(data: imageData) {
                images.append(image)
            }
        }
        return images
    }
    
    static  func boolValueToIntValue(boolValue:Bool)->Int{
        return boolValue == true  ? 1 : 0
    }
    
    
    static  func URLToData(URLString:URL)->Data? {
        if let videoData = try? Data(contentsOf: URLString)  {
            return videoData
        }else{
            return nil
        }
    }
    
    static  func validateNumberBasedOnCodeCountry(codeCounty:String)-> ValidationInput? {
        if codeCounty == "+966" {
            return .saudiPhone
        }else if codeCounty == "+20"{
            return .egyptPhone
        }
        return nil
    }
    
}
