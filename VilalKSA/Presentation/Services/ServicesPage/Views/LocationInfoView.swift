//
//  LocationInfoView.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI

struct LocationInfoView: View {
    let locationName: String?
    var body: some View {
        HStack {
            Image(R.image.location_icon.name)
                .resizable()
                .frame(width: 12, height: 15, alignment: .center)
            TextMeduim12(text: locationName ?? "المنصورة المشاية كوبري طلخا", textColor: R.color.color42526E.name.getColor())
                .multilineTextAlignment(.leading)
        }
    }
}

