//
//  TextFieldStyles.swift
//  VilalKSA
//
//  Created by Elkilany on 07/12/2023.
//


import SwiftUI

struct GeneralTextField: View {
    
    @Binding var text: String
    @State private var isInputValid: Bool = true
    let placeholder: LocalizedStringKey
    let imageName:String
    let keyboardType:UIKeyboardType?
    let validationClosure: (String) -> Bool
    
    var body: some View {
        
        HStack {
            Image(imageName)
                .padding(.leading, 10)
            
            ZStack(alignment: .leading) {
                
                if text.isEmpty {
                    Text(placeholder)
                        .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                        .foregroundColor(Color.gray.opacity(0.5))
                }
                TextField("", text: $text)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.leading, 5)
                    .keyboardType(keyboardType ?? .default)
                    .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                    .onChange(of: text) { newValue in
                        self.isInputValid = self.validationClosure(newValue)
                    }
            }
        }
        .frame(height: 50 )
        .background(isInputValid ? R.color.colorF7F8F8.name.getColor() : Color.red.opacity(0.2))
        .cornerRadius( 25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(isInputValid ? Color.clear : Color.red, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct PasswordTextField: View {
    @Binding var text: String
    @State private var isInputValid: Bool = true
    @State private var isShowPassword: Bool = true
    let keyboardType:UIKeyboardType?
    let placeholder: LocalizedStringKey
    let validationClosure: (String) -> Bool
    

    var body: some View {
        
        HStack {
            Image(R.image.passwordIcon.name)
                .padding(.leading, 10)
            if isShowPassword {
                ZStack(alignment: .leading) {
                    
                    if text.isEmpty {
                        Text(placeholder)
                            .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5)) // Change the color here
                    }
                    
                    TextField("", text: $text)
                        .keyboardType(keyboardType ?? .default)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.leading, 5)
                        .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                        .onChange(of: text) { newValue in
                            self.isInputValid = self.validationClosure(newValue)
                        }
                  
                }
             
            }else{
                ZStack(alignment: .leading) {
                    
                    if text.isEmpty {
                        Text(placeholder)
                            .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                       
                    }
                    
                        SecureField("", text: $text)
                        .keyboardType(keyboardType ?? .default)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.leading, 5)
                        .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                        .onChange(of: text) { newValue in
                            self.isInputValid = self.validationClosure(newValue)
                        }
                   
                }
            }

            Button {
                isShowPassword.toggle()
            } label: {
                Image( isShowPassword ? R.image.hidePasswordIcon.name : R.image.showPassword.name )
                    .foregroundColor(R.color.color7A869A.name.getColor())
                    .padding(.trailing, 20)
            }
        }
        .frame(height: 50 )
        .background(isInputValid ? R.color.colorF7F8F8.name.getColor() : Color.red.opacity(0.3))
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(isInputValid ? Color.clear : Color.red, lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
}
