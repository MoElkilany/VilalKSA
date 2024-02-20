//
//  SliderView.swift
//  VilalKSA
//
//  Created by Elkilany on 14/02/2024.
//

import SwiftUI

struct SliderView: View {
    @Binding var sliderValue: Int
    let localizedTitle: LocalizedStringKey
    let localizedKey: LocalizedStringKey
    let valueFrom: Double
    let valueTo: Double
    var body: some View {
        VStack(spacing:0){
            HStack{
                TextBold12(textKey: localizedTitle, textColor: R.color.color172B4D.name.getColor())
                Spacer()
                TextBold14(text: (String(sliderValue)), textColor: R.color.colorPrimary.name.getColor())
                TextBold14(textKey: localizedKey, textColor: R.color.colorPrimary.name.getColor())
            }
            .padding(.horizontal,8)
            
            Slider(value: Binding<Double>(
                get: { Double(sliderValue) },
                set: { newValue in sliderValue = Int(newValue) }
            ), in: valueFrom...valueTo, step: 1.0)
            .tint(R.color.colorPrimary.name.getColor())
        }
        .padding(.horizontal,4)
        //            Slider(value: $sliderValue, in: valueFrom...valueTo, step: 1.0)
        //        }
    }
}
