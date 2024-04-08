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



enum ValidationInput {
    case email
    case phone
    case password
    case word
    case saudiPhone
    case egyptPhone
    case cardNumber
    case expireDate
    case cvvNumber
    
    func isValid(input: String, count: Int = 0) -> Bool {
        switch self {
        case .email:
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: input)
            
        case .phone:
            return input.count >= 3 && input.isNumeric() 
        case .password:
            let digitCount = input.count
            return  digitCount >= 8
        case .word:
            return input.count >= 3
        case .saudiPhone:
            return input.isValidSaudiNumber()
        case .egyptPhone:
            return input.isValidEgyptionNumber()
            
        case .cardNumber:
            return input.isValidCardNumber()
        case .expireDate:
            return input.isValidateExpiryDate()
        case .cvvNumber:
            return input.count == 3
        }
    
    }
    
    func error() -> LocalizedStringKey {
        switch self {
        case .email:
            R.string.localizable.notValidEmail.localized
        case .phone:
            R.string.localizable.notValidPhone.localized
        case .password:
            R.string.localizable.password_Required.localized
        case .word:
            R.string.localizable.field_Required.localized
        case .saudiPhone:
            R.string.localizable.please_Enter_Saudian_Number.localized
        case .egyptPhone:
            R.string.localizable.please_Enter_Egyption_Number.localized
        case .cardNumber:
            R.string.localizable.enter_Valid_Card_Number.localized
        case .expireDate:
            R.string.localizable.enter_Valid_Expire_Date.localized
        case .cvvNumber:
            R.string.localizable.enter_Valid_CVV_Number.localized
        }
    }
}

struct VilalTextField: View {
    
    @Binding var text: String
    let placeholder: LocalizedStringKey
    let imageName:String
    let keyboardType:UIKeyboardType?
    let validationInput: ValidationInput
    let submitButton: Bool?
    let onSubmit: (Bool) -> Void
    
    init(text: Binding<String>, placeholder: LocalizedStringKey, imageName: String, keyboardType: UIKeyboardType?, validationInput: ValidationInput, submitButton: Bool?, onSubmit: @escaping (Bool) -> Void) {
        self._text = text
        self.placeholder = placeholder
        self.imageName = imageName
        self.keyboardType = keyboardType
        self.validationInput = validationInput
        self.submitButton = submitButton
        self.onSubmit = onSubmit
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(imageName)
                    .padding(.leading, 10)
                
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .padding(.leading, 5)
                            .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    TextField("", text: $text)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.leading, 5)
                        .keyboardType(keyboardType ?? .default)
                        .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 50 )
            .background(  R.color.colorF7F8F8.name.getColor())
            .cornerRadius( 25)
           
            .padding(.horizontal)
            
            if self.submitButton == true {
                if  !validationInput.isValid(input: self.text) {
                    ErrorTextView(errorText: validationInput.error())
                        .padding(.leading, 5)
                    let _ = self.onSubmit(false)
                }else{
                    let _ = self.onSubmit(true)
                }
            }
        }
        .padding(.vertical, 5)
    }
    
}








struct VilalPasswordTextField: View {
    
    @Binding var text: String
    let placeholder: LocalizedStringKey
    let keyboardType:UIKeyboardType?
    let validationInput: ValidationInput
    let submitButton: Bool?
    let onSubmit: (Bool) -> Void
    @State private var isShowPassword: Bool = true

    
    init(text: Binding<String>, placeholder: LocalizedStringKey, keyboardType: UIKeyboardType?, validationInput: ValidationInput, submitButton: Bool?, onSubmit: @escaping (Bool) -> Void) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.validationInput = validationInput
        self.submitButton = submitButton
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
        HStack {
            Image(R.image.passwordIcon.name)
                .padding(.leading, 10)
            if isShowPassword {
                ZStack(alignment: .leading) {
                    
                    if text.isEmpty {
                        Text(placeholder)
                            .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    
                    TextField("", text: $text)
                        .keyboardType(keyboardType ?? .default)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.leading, 5)
                        .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
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
        .background( R.color.colorF7F8F8.name.getColor() )
        .cornerRadius(25)
      
        .padding(.horizontal)
        
        if self.submitButton == true {
            if !validationInput.isValid(input: text) { 
                ErrorTextView(errorText: validationInput.error())
                    .padding(.leading, 5)
                let _ = self.onSubmit(false)

            }else{
                let _ = self.onSubmit(true)
            }
        }
    }
    .padding(.vertical, 5)
        
        
    }
    
}
