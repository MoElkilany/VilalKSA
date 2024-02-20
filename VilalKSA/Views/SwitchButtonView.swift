//
//  SwitchButtonView.swift
//  VilalKSA
//
//  Created by Elkilany on 14/02/2024.
//

import SwiftUI

struct SwitchButtonView: View {
    let localizedTitle: LocalizedStringKey
    @Binding var switchValue: Bool
    var body: some View {
        HStack{
            TextBold12(textKey: localizedTitle, textColor: R.color.color172B4D.name.getColor())
            Spacer()
            Toggle("", isOn: $switchValue)
                .toggleStyle(SwitchToggleStyle(tint:  R.color.colorPrimary.name.getColor()))
                
        }
    }
}

