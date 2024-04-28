//
//  VilalIconWithValueView.swift
//  VilalKSA
//
//  Created by Elkilany on 04/02/2024.
//

import SwiftUI

struct VilalIconWithValueView: View {
    var icon:String?
    var value:String?
    var valueLocalized:LocalizedStringKey? = nil
    
    var body: some View {
        
        HStack(spacing:2) {
            Image(icon ?? R.image.bed_icon.name)
                .resizable()
                .frame(width: 15, height: 12, alignment: .center)
            
            if valueLocalized == nil {
                TextMeduim10(text: value ?? "0", textColor: R.color.color172B4D.name.getColor())
            }else{
                TextMeduim10(textKey: valueLocalized ?? "0", textColor: R.color.color172B4D.name.getColor())
            }
        }
    }
}

#Preview {
    VilalIconWithValueView()
}
