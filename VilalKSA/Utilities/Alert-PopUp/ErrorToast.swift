//
//  ErrorToast.swift
//  VilalKSA
//
//  Created by Elkilany on 11/12/2023.
//

import SwiftUI

struct ErrorToast: View {
    
    let title: LocalizedStringKey?

    var body: some View {
        
        HStack(spacing: 8) {
            Image(R.image.xCircle.name)
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
            
            Text(title ?? "" )
                .foregroundColor(.white)
                .font(Font.custom(FontName.cairoRegular.rawValue, size: 16))
        }
        .padding(16)
        .background(.red)
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}

struct ToastBottomSecond: View {
    let title: LocalizedStringKey?
    let subTitle: String?

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(R.image.checkmark_Success.name)
                .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 4) {
                TextBold16(textKey: title ?? "", textColor:R.color.colorPrimary.name.getColor())
                TextRegular14(text: subTitle ?? "", textColor: Color.gray)
            }
            Spacer()
        }
        .foregroundColor(.black)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 42, trailing: 16))
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .shadow(color: .black.opacity(0.1), radius: 40, x: 0, y: -4)
    }
}
