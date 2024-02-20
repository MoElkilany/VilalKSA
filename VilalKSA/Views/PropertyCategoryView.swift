//
//  PropertyCategoryView.swift
//  VilalKSA
//
//  Created by Elkilany on 05/02/2024.
//

import SwiftUI

struct PropertyCategoryView: View {

    let propertyCategory: String?
    var body: some View {
        HStack {
            Image(R.image.propertyCategory.name)
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
            TextBold12(text: propertyCategory ?? "شقة ايجار يومي", textColor: Color.white)
        }
        .padding(12)
        .padding(.horizontal,12)
        .background(R.color.colorF8B945.name.getColor())
        .cornerRadius(30)
    }
}


