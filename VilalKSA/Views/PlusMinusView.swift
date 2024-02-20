//
//  PlusMinusView.swift
//  VilalKSA
//
//  Created by Elkilany on 14/02/2024.
//

import SwiftUI

struct PlusMinusView: View {
    let localizedTitle: LocalizedStringKey
    
    @State private var defualtValue: Int = 1
    let finalValue: (Int) -> Void
    
    
    init(localizedTitle: LocalizedStringKey, defualtValue: Int, finalValue: @escaping (Int) -> Void) {
        self.localizedTitle = localizedTitle
        self.defualtValue = defualtValue
        self.finalValue = finalValue
    }
    
    
    var body: some View {
        HStack {
            
            TextBold12(textKey: localizedTitle, textColor: R.color.color172B4D.name.getColor())
            Spacer()
            HStack {
                Button(action: {
                    defualtValue += 1
                    finalValue(defualtValue)
                }) {
                    Image(R.image.plusButton.name)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
                TextBold18(text: "\(defualtValue)", textColor: R.color.color172B4D.name.getColor())
                    .padding(.horizontal)
                
                Button(action: {
                    if defualtValue > 0
                    {
                        defualtValue -= 1
                        finalValue(defualtValue)
                    }
                }) {
                    
                    
                    Image(R.image.minusButton.name)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                }
                .disabled(defualtValue == 1)
            }
        }
    }
}
