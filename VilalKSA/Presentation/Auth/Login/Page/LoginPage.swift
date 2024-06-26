//
//  LoginPage.swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//

import SwiftUI
import UIPilot
import PopupView
import CountryPicker
import LanguageManagerSwiftUI


struct LoginPage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    @StateObject var viewModel = LoginViewModel()
    @State var phoneNumber: String = ""
    @State var password: String = ""
    @State var phoneWithCodeCounty = ""
    @State private var country: Country = Country.init(countryCode: GeneralKeys.sa.rawValue)
    @State private var isShowingCountryPicker = false
    @State private var submitButton = false

    var body: some View {
        ZStack{
            
            VStack{
                Image(R.image.cityLifeIcon.name)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 144, alignment: .center)
                    .padding(.bottom ,32)
                
                ScrollView(showsIndicators:false){

                    HStack {
                        VStack(alignment: .leading) {
                            TextExtraBold16(textKey: R.string.localizable.login.localized, textColor: R.color.color172B4D.name.getColor())
                                .padding(.bottom,1)
                            TextRegular12(textKey: R.string.localizable.enter_Your_Phone.localized, textColor: R.color.color7A869A.name.getColor())
                        }
                        Spacer()
                    }
                    .padding([.vertical ,.horizontal],22)
                    
                    HStack {
                        
                        VilalTextField(text: $phoneNumber, placeholder:  R.string.localizable.enter_Phone_Number.localized, imageName:"" , keyboardType: .asciiCapableNumberPad, validationInput: Convert.validateNumberBasedOnCodeCountry(codeCounty: country.dialingCode ?? "+966") ?? .phone, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isValidUserName = isValid
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
                            print("the countryCode is ",choosenCountry.countryCode )
                            print("the countryName is ",choosenCountry.countryName )
                            print("the dialingCode is ",choosenCountry.dialingCode ?? "" )
                        }
                    }
                    
                    VilalPasswordTextField(text: $password, placeholder: R.string.localizable.password.localized, keyboardType: .default,validationInput: .password, submitButton: submitButton, onSubmit: { isValid in
                        viewModel.isPasswordValid = isValid
                    })
                    .padding(.top,12)
                    
                    HStack {
                        Button(R.string.localizable.forget_Password.localized) {
                            pilot.push(.forgetPassword)
                        }
                        .foregroundColor(R.color.color42526E.name.getColor())
                        .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                        Spacer()
                    }
                    .padding([.vertical ,.horizontal],22)
                    
                    DefaultButton(title:  R.string.localizable.login.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        phoneWithCodeCounty = viewModel.constructPhoneWithCodeCounty(phoneNumber, country: country)

                        viewModel.phoneNumber = phoneNumber
                        viewModel.countryCode = country.dialingCode ?? ""
                        viewModel.fullNumber = phoneWithCodeCounty
                        submitButton = true
                        if self.viewModel.isValidForm(){
                            let loginRequest = LoginRequest(phone: phoneWithCodeCounty.convertArabicNumberToEnglishNumber(), password: password.convertArabicNumberToEnglishNumber())
                            viewModel.login(request: loginRequest)
                        }
                    }, fontWeight: .bold)
                    
                    Button( R.string.localizable.enter_AS_GUEST.localized) {
                        UserDefaults.standard.set(true, forKey: Constants.asGuest.rawValue)
                        pilot.push(.home)
                    }
                    .foregroundColor(R.color.color42526E.name.getColor())
                    .font(Font.custom(FontName.cairoRegular.rawValue, size: 14))
                    Spacer()
                }

                HStack {
                    TextRegular12(textKey:  R.string.localizable.dont_Have_Account.localized, textColor: R.color.color42526E.name.getColor())
                    Button( R.string.localizable.create_New_Account.localized) {
                        pilot.push(.createAccountPage)
                    }
                    .foregroundColor(R.color.colorPrimary.name.getColor())
                    .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                }
                .padding(22)
                .padding(.bottom,12)
            }
            
            if self.viewModel.state == .loading {
                OnScreenLoading
            }
        }
        .popup(isPresented: self.$viewModel.errorPopUp) {
            ErrorToast(title: self.viewModel.errorMessage)
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .autohideIn(5)
        }
        .onAppear(perform: {
            self.phoneNumber = ""
            self.password = ""
        })
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onReceive(self.viewModel.$isNotVerified, perform: navigateToVerificationPage(isNotVerified:))
        .onReceive(self.viewModel.$loggedin, perform: navigateToHomePage(isLoggedin:))

        .disabled(self.viewModel.state == .loading )
        .background(.white)
        .padding(.top, 40)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    func loginAction() {
        
        phoneWithCodeCounty = viewModel.constructPhoneWithCodeCounty(phoneNumber, country: country)
        let loginRequest = LoginRequest(phone: phoneWithCodeCounty, password: password)
        viewModel.login(request: loginRequest)
    }
    
    func navigateToVerificationPage(isNotVerified: Bool ) {
        if isNotVerified {
            pilot.push(.verificationCode(phoneNumber:  self.phoneWithCodeCounty, navigationChecker: .isForgetPassword))
        }
    }

    func navigateToHomePage(isLoggedin: Bool ) {
        if isLoggedin {
            UserDefaults.standard.setValue(false, forKey: Constants.asGuest.rawValue)
            pilot.push(.home)
        }
    }
}



struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}



