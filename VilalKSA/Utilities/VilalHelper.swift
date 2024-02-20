//
//  VilalHelper.swift
//  VilalKSA
//
//  Created by Elkilany on 31/01/2024.
//

import Foundation
import SwiftUI

class VilalHelper {
    
    let shared = VilalHelper()
    private init() {}
    
    static func getFromToPrice(fromPrice: String, toPrice: String) -> String {
        let fullPrice = (fromPrice + " - " +  toPrice )
        return (fullPrice)
    }
    
    static func makePhoneCall(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
        }
    }
    
    
    static func openWhatsApp(urlString:String) {
        
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urlStringEncoded = urlStringEncoded, let url = URL(string: urlStringEncoded) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("WhatsApp is not installed on the device.")
            }
        }
    }
}
