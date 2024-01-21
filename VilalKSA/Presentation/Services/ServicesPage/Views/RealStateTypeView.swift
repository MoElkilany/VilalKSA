//
//  RealStateTypeView.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI

struct RealStateTypeView: View {

    var realStateTypeName: LocalizedStringKey?
    var body: some View {
        HStack {
            Image(R.image.apartment_icon.name)
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)

            TextMeduim(text: realStateTypeName ?? "شقة", textColor: R.color.color7A869A.name.getColor())
        }
        .padding(6)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    RealStateTypeView()
}
