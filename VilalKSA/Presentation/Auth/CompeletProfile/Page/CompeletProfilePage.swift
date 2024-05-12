//
//  CompeletProfilePage.swift
//  VilalKSA
//
//  Created by Elkilany on 15/12/2023.
//

import SwiftUI
import UIPilot

struct CompeletProfilePage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    @StateObject var viewModel = CompeletProfileViewModel()
    @State var firstName: String = ""
    @State var secondName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var rewritePassword: String = ""
    let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"
    @State private var submitButton = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image(R.image.back_button_right_icon.name)
                        .resizable()
                        .frame(width: 25, height: 15)
                        .scaleEffect(x:local == "en" ?  -1 : 1  , y: local == "en" ?  1 : -1 )
                        .onTapGesture {
                            pilot.pop()
                        }
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.horizontal, 25)
                
                ScrollView(showsIndicators:false){

                    TextBold16(textKey: R.string.localizable.completing_Personal_Profile_Information.localized, textColor: R.color.color172B4D.name.getColor())
                        .padding(.vertical,4)
                    
                    VStack {
                        VilalTextField(text: $firstName, placeholder:  R.string.localizable.enter_First_Name.localized, imageName:"" , keyboardType: .default, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isVaildFirstName = isValid
                        })

                        VilalTextField(text: $secondName, placeholder:  R.string.localizable.enter_Second_Name.localized, imageName:"" , keyboardType: .default, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isVaildSecondName = isValid
                        })
                        
                        VilalTextField(text: $email, placeholder:  R.string.localizable.enter_Email.localized, imageName:"" , keyboardType: .default, validationInput: .email, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isVaildEmailName = isValid
                        })

                        VilalPasswordTextField(text: $password, placeholder: R.string.localizable.password.localized, keyboardType: .default,validationInput: .password, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isVaildPassword = isValid
                        })
                        
                        VilalPasswordTextField(text: $rewritePassword, placeholder: R.string.localizable.rewrite_Password.localized, keyboardType: .default,validationInput: .password, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isVaildRewritePassword = isValid
                        })
                    }
                    .padding(.horizontal,2)
                }
                
                DefaultButton(title: R.string.localizable.create_Account.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                    createAccount()
                }, fontWeight: .bold)
                .padding(.bottom, 30)
            }
            
            if viewModel.state == .loading {
                OnScreenLoading
            }
        }
        .popup(isPresented: $viewModel.errorPopUp) {
            ErrorToast(title: (viewModel.errorMessage))
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .autohideIn(5)
        }
        
        .popup(isPresented: $viewModel.successBottomSheet) {
            ToastBottomSecond(title: R.string.localizable.successfully_Registered.localized, subTitle: viewModel.successTitle, subTitleLocalized: "  ")
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .autohideIn(5)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onReceive(viewModel.$isLogin, perform: navigate(isLogin:))
        .disabled(viewModel.state == .loading)
        .background(.white)
        .padding(.top, 30)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private func createAccount() {
        submitButton = true
        if viewModel.isValidForm(){
            let completeProfileModel = CompleteProfileModelRequest(firstName: firstName, secondName: secondName, email: email, password: password.convertArabicNumberToEnglishNumber(), confirmPassword: rewritePassword.convertArabicNumberToEnglishNumber())
            viewModel.compeletProfile(request: completeProfileModel)
        }
    }
}


extension CompeletProfilePage {

    func navigate(isLogin:Bool) {
        if isLogin {
            pilot.popTo(.login)
        }
    }
}



#Preview{
    CompeletProfilePage()
}


