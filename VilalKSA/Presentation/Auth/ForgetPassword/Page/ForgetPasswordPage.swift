//
//  ForgetPasswordPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/12/2023.
//

import SwiftUI
import CountryPicker
import UIPilot

struct ForgetPasswordPage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    @State var phoneNumber: String = ""
    @State private var country: Country = Country.init(countryCode: GeneralKeys.sa.rawValue)
    @State private var isShowingCountryPicker = false
    @State var phoneWithCodeCounty = ""
    @StateObject var viewModel = ForgetPasswordViewModel()
    let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
    @State private var submitButton = false

    
    var body: some View {
        
        ZStack{
            VStack{
                HStack{
                        Image( R.image.back_button_right_icon.name  )
                            .resizable()
                            .frame(width: 25, height: 15)
                            .scaleEffect(x:local == "en" ?  -1 : 1  , y: local == "en" ?  1 : -1 )
                            .onTapGesture {
                                pilot.pop()
                            }
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.horizontal,  25)
                .padding(.bottom, 20)
                
                ScrollView(showsIndicators:false){
                    HStack {
                        VStack(alignment: .leading) {
                            TextExtraBold16(textKey: R.string.localizable.forget_Your_Password.localized, textColor: R.color.color172B4D.name.getColor())
                                .padding(.bottom,1)
                            TextRegular12(textKey: R.string.localizable.enter_Phone_Number_For_Password_Reset.localized, textColor: R.color.color7A869A.name.getColor())
                        }
                        Spacer()
                    }
                    .padding([.vertical ,.horizontal],22)
                    .padding(.bottom, 12)
                    
                    HStack {
                    
                        VilalTextField(text: $phoneNumber, placeholder:  R.string.localizable.enter_Phone_Number.localized, imageName:"" , keyboardType: .asciiCapableNumberPad, validationInput: Convert.validateNumberBasedOnCodeCountry(codeCounty: country.dialingCode ?? "+966") ?? .phone, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isValidPhoneNumber = isValid
                        })
                        
                        Button {
                            isShowingCountryPicker = true
                        } label: {
                            CodeCountryView(countryCode: country.dialingCode , countyFlag: country.flag)
                        }
                    }
                    .sheet(isPresented: $isShowingCountryPicker) {
                        CountryPickerHandler { choosenCountry in
                            country = choosenCountry
                        }
                    }
                    
                    DefaultButton(title: R.string.localizable.send_Code.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        sendCodeAction()
                    }, fontWeight: .bold)
                    .padding(.top,20)
                }
  
                HStack {
                    TextRegular12(textKey: R.string.localizable.remember_The_Password.localized, textColor: R.color.color42526E.name.getColor())
                    TextRegular12(textKey: R.string.localizable.login.localized, textColor: R.color.colorPrimary.name.getColor())
                        .onTapGesture {
                            pilot.pop()
                        }
                }
                .padding(.bottom,50)
            }
            if viewModel.state == .loading {
                OnScreenLoading
            }
        }
        
        .popup(isPresented: $viewModel.errorPopUp) {
            ErrorToast(title:  (viewModel.errorMessage))
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .autohideIn(5)
        }
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onReceive(viewModel.$isNotVerified, perform: navigateToVerificationPage(isNotVerified:))
        .disabled(viewModel.state == .loading )
        .background(.white)
        .padding(.top, 40)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard, edges: .bottom)

    }
    
    
    func sendCodeAction() {
        self.submitButton = true
        if viewModel.validForm(){
            phoneWithCodeCounty = viewModel.constructPhoneWithCodeCounty(phoneNumber, country: country)
            viewModel.forgetPasswordRequest(request: ForgetPasswordRequest(phone: phoneWithCodeCounty))
        }
    }
}


extension ForgetPasswordPage {
    func navigateToVerificationPage(isNotVerified: Bool ) {
        if isNotVerified{
            pilot.push(.verificationCode(phoneNumber:  self.phoneWithCodeCounty, navigationChecker: .isForgetPassword))
        }
    }
}

struct ForgetPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordPage()
    }
}
