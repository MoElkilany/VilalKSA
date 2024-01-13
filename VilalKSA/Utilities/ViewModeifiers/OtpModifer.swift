//
//  OtpModifer.swift
//  VilalKSA
//
//  Created by Elkilany on 14/12/2023.
//

import SwiftUI
import Combine

struct OtpModifer: ViewModifier {
    
    @Binding var pin : String
    
    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: 50, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(R.color.colorPrimary.name.getColor(), lineWidth: 1)
            )
            .background(R.color.colorF7F8F8.name.getColor().cornerRadius(30))

    }
}
