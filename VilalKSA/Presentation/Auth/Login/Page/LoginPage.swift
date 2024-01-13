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


struct LoginPage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    @StateObject var viewModel = LoginViewModel()
    @State var phoneNumber: String = ""
    @State var password: String = ""
    @State var phoneWithCodeCounty = ""
    @State private var country: Country = Country.init(countryCode: GeneralKeys.sa.rawValue)
    @State private var isShowingCountryPicker = false
    
    var body: some View {
        ZStack{
            
            VStack{
                Image(R.image.cityLifeIcon.name)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 144, alignment: .center)
                    .padding(.bottom ,32)
                
                ScrollView{
                    
                    HStack {
                        VStack(alignment: .leading) {
                            TextExtraBold16(text: "Login", textColor: R.color.color172B4D.name.getColor())
                                .padding(.bottom,1)
                            TextRegular12(text: "Enter your mobile number", textColor: R.color.color7A869A.name.getColor())
                        }
                        Spacer()
                    }
                    .padding([.vertical ,.horizontal],22)
                    
                    HStack {
                        GeneralTextField(
                            text: $phoneNumber,
                            placeholder: "Enter the phone number",
                            imageName: R.image.phoneIcon.name ,
                            keyboardType:.numberPad,
                            validationClosure: { input in
                                let digitsOnly = input.allSatisfy { $0.isNumber }
                                let letterCount = input.filter { $0.isNumber }.count
                                return letterCount >= 3 && digitsOnly
                            }
                        )
                        
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
                    
                    PasswordTextField(text: $password, keyboardType: .default, placeholder: "Password", validationClosure: { input in
                        let letterCount = input.filter { $0.isLetter }.count
                        let digitCount = input.filter { $0.isNumber }.count
                        return  letterCount >= 8 || digitCount >= 8
                    }).padding(.top,12)
                    
                    HStack {
                        Button("Did you forget your password?") {
                            pilot.push(.forgetPassword)
                        }
                        .foregroundColor(R.color.color42526E.name.getColor())
                        .font(.system(size: 12))
                        Spacer()
                    }
                    .padding([.vertical ,.horizontal],22)
                    
                    DefaultButton(title: "Login", backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        loginAction()
                    }, fontWeight: .bold)
                    Spacer()
                }
                
                HStack {
                    TextRegular12(text: "Don't have an account?", textColor: R.color.color42526E.name.getColor())
                    Button("Create New Account") {
                        pilot.push(.createAccountPage)
                    }
                    .foregroundColor(R.color.colorPrimary.name.getColor())
                    .font(.system(size: 12))
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
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onReceive(self.viewModel.$isNotVerified, perform: navigateToVerificationPage(isNotVerified:))
        .disabled(self.viewModel.state == .loading )
        
        .background(.white)
        .padding(.top, 40)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    func loginAction() {
        
        guard viewModel.validateInputs(self.phoneNumber, self.password) else {
            return
        }
        
        phoneWithCodeCounty = viewModel.constructPhoneWithCodeCounty(phoneNumber, country: country)
        let loginRequest = LoginRequest(phone: phoneWithCodeCounty, password: password)
        viewModel.login(request: loginRequest)
    }
    
    func navigateToVerificationPage(isNotVerified: Bool ) {
        if isNotVerified {
            pilot.push(.verificationCode(phoneNumber:  self.phoneWithCodeCounty, navigationChecker: .isForgetPassword))
        }
    }
}



struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}



