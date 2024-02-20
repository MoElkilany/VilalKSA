//
//  MultilineTextField.swift
//  VilalKSA
//
//  Created by Elkilany on 17/02/2024.
//

import SwiftUI

struct MultilineTextField: View {
    
    @Binding var text: String
    let submitButton: Bool?
    let placeholder: LocalizedStringKey
    let onSubmit: (Bool) -> Void
    let borderColor: Color?
    
    init(text: Binding<String>, submitButton: Bool?, placeholder: LocalizedStringKey, borderColor: Color? = nil, onSubmit: @escaping (Bool) -> Void) {
        self._text = text
        self.submitButton = submitButton
        self.placeholder = placeholder
        self.onSubmit = onSubmit
        self.borderColor = borderColor
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .padding(4)
                    .frame(minHeight: 150, alignment: .leading)
                    .font(Font.custom(FontName.cairoMedium.rawValue, size: 12))
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                    )
                if text.isEmpty {
                    Text(placeholder)
                        .font(Font.custom(FontName.cairoMedium.rawValue, size: 12))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 12)
                }
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(borderColor ?? .clear, lineWidth: 1)
            )
            
            if self.submitButton == true {
                if self.text.isEmpty == true {
                    let _: Void? = self.onSubmit(false)
                    ErrorTextView(errorText: R.string.localizable.field_Required.localized)
                }else{
                    let _: Void? = self.onSubmit(true)
                }
            }
        }
    }
    
    
   

}
