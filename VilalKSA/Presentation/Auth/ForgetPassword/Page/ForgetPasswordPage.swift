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


    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ZStack{
            VStack{
                HStack{
                    Button {
                        pilot.pop()
                    } label: {
                        Image(R.image.back_button_left_icon.name)
                        
                    }
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.horizontal, width / 20)
                .padding(.bottom, 20)
                
                ScrollView{
                    
                    HStack {
                        VStack(alignment: .leading) {
                            TextExtraBold16(text: "Forget your password?", textColor: R.color.color172B4D.name.getColor())
                                .padding(.bottom,1)
                            TextRegular12(text: "Please enter your phone number to request a password reset", textColor: R.color.color7A869A.name.getColor())
                        }
                        Spacer()
                    }
                    .padding([.vertical ,.horizontal],22)
                    .padding(.bottom, 12)
                    
                    HStack {
                        GeneralTextField(
                            text: $phoneNumber,
                            placeholder: "Enter the phone number",
                            imageName: R.image.phoneIcon.name, keyboardType: .numberPad ,
                            validationClosure: { input in
                                phoneNumber = input
                                let digitsOnly = input.allSatisfy { $0.isNumber }
                                return digitsOnly
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
                        }
                    }
                    
                    DefaultButton(title: "Send Code", backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        sendCodeAction()
                    }, fontWeight: .bold)
                    .padding(.top,20)
                    
                    HStack {
                        TextRegular12(text: "Do you remember the password?", textColor: R.color.color42526E.name.getColor())
                        Button("Login") {
                            pilot.pop()
                        }
                        .foregroundColor(R.color.colorPrimary.name.getColor())
                        .font(.system(size: 12,weight: .heavy))
                    }
                    .padding(.top,height / 1.8)
                }
            }
                if viewModel.state == .loading {
                    OnScreenLoading
                }
        }
            .ignoresSafeArea(.all)
        }
        .popup(isPresented: $viewModel.errorPopUp) {
            ErrorToast(title: viewModel.errorMessage)
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
          guard viewModel.validatePhoneNumber(phoneNumber) else {
              return
          }
          phoneWithCodeCounty = viewModel.constructPhoneWithCodeCounty(phoneNumber, country: country)
          viewModel.forgetPasswordRequest(request: ForgetPasswordRequest(phone: phoneWithCodeCounty))
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
