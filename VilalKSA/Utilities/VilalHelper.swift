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
    
    static func getFromToPrice(fromPrice: String, toPrice: String) -> LocalizedStringKey {
        let fullPrice = (fromPrice + " - " +  toPrice )
        return LocalizedStringKey(fullPrice)
    }
}
