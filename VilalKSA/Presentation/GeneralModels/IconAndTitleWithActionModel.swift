//
//  IconAndTitleWithActionModel.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import SwiftUI

struct IconAndTitleWithActionModel:Identifiable {
    let id = UUID()
    var icon: String
    var text: LocalizedStringKey
    var action: (()->())?
}
