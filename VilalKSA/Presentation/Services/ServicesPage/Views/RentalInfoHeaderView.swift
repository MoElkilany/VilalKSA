//
//  RentalInfoHeaderView.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI

struct RentalInfoHeaderView: View {
    var name: String?
    var realStateCategory: String?
    
    var body: some View {
        HStack {
            RealStateTypeView(realStateTypeName: realStateCategory)
                .padding(.horizontal,2)
            Spacer()
//            TextBold14(text: name ?? "شقة للايجار", textColor: R.color.color172B4D.name.getColor())

        }
    }
}

#Preview {
    RentalInfoHeaderView()
}
