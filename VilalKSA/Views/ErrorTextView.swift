//
//  ErrorTextView.swift
//  VilalKSA
//
//  Created by Elkilany on 16/02/2024.
//

import SwiftUI

struct ErrorTextView: View {
    let errorText: LocalizedStringKey
    var body: some View {
        Text(errorText)
            .padding(.leading, 15)
            .foregroundColor(.red)
            .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
    }
}
