//
//  CreateAccountPage.swift
//  VilalKSA
//
//  Created by Elkilany on 15/12/2023.
//

import SwiftUI
import UIPilot
import CountryPicker

struct CreateAccountPage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    @StateObject var viewModel = CreateAcountViewModel()
    @State var phoneNumber: String = ""
    @State private var country: Country = Country.init(countryCode: GeneralKeys.sa.rawValue)
    @State private var isShowingCountryPicker = false
    @State var phoneWithCodeCounty = ""
    
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
                            TextExtraBold16(text: "Create Account", textColor: R.color.color172B4D.name.getColor())
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
                            imageName: R.image.phoneIcon.name, keyboardType: .numberPad ,
                            validationClosure: { input in
                                let digitsOnly = input.allSatisfy { $0.isNumber }
                                let letterCount = input.filter { $0.isNumber }.count
                                return letterCount >= 5 && digitsOnly
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
                    
                    DefaultButton(title: "Create Account", backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        if phoneNumber.isEmpty {
                            viewModel.errorMessage = "Phone Number Required"
                            viewModel.errorPopUp = true
                            return
                        }
                        let phoneWithCodeCountyValue = ((country.dialingCode ?? "") + (phoneNumber)) 
                        self.phoneWithCodeCounty = phoneWithCodeCountyValue
                        viewModel.registerPhone(request: RegisterPhoneRequest(phone:self.phoneWithCodeCounty  ))
                        
                    }, fontWeight: .bold)
                    .padding(.top , 40)
                    
                    Spacer()
                }
                
                HStack {
                    TextRegular12(text: "Have an account?", textColor: R.color.color42526E.name.getColor())
                    Button("Login") {
                        pilot.pop()
                    }
                    .foregroundColor(R.color.colorPrimary.name.getColor())
                    .font(.system(size: 12))
                }
                .padding(22)
                .padding(.bottom,12)
            }
            
            if viewModel.state == .loading {
                OnScreenLoading
            }
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
    
}


extension CreateAccountPage {
    func navigateToVerificationPage(isNotVerified: Bool ) {
        
        if isNotVerified{
            pilot.push(.verificationCode(phoneNumber:  self.phoneWithCodeCounty, navigationChecker: .isFromSignUp))
        }
    }
}


struct CreateAccountPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountPage()
    }
}
