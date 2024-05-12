//
//  NewPasswordPage.swift
//  VilalKSA
//
//  Created by Elkilany on 15/12/2023.
//

import SwiftUI
import UIPilot

struct NewPasswordPage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    @StateObject var viewModel = NewPasswordViewModel()
    
    @State var password : String = ""
    @State var confirmNewPassword : String = ""
    @State private var submitButton = false
    let local =   UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"

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
                    .padding(.horizontal,20)
                    
                    ScrollView(showsIndicators:false){
                        HStack {
                            VStack(alignment: .leading) {
                                TextExtraBold16(textKey:R.string.localizable.create_New_Password.localized , textColor: R.color.color172B4D.name.getColor())
                                    .padding(.bottom,1)
                                TextRegular12(textKey: R.string.localizable.new_Password_Must_Be_Different.localized, textColor: R.color.color7A869A.name.getColor())
                            }
                            Spacer()
                        }
                        .padding([.vertical ,.horizontal],22)
                        
                        
                        VilalPasswordTextField(text: $password, placeholder: R.string.localizable.password.localized, keyboardType: .default,validationInput: .password, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isVaildPassword = isValid
                        })
                        
                        VilalPasswordTextField(text: $confirmNewPassword, placeholder: R.string.localizable.rewrite_Password.localized, keyboardType: .default,validationInput: .password, submitButton: submitButton, onSubmit: { isValid in
                            viewModel.isVaildRewritePassword = isValid
                        })
                        
                        
                        
                        DefaultButton(title: R.string.localizable.reset_Password.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                            forgetPasswordAction()
                        }, fontWeight: .bold)
                    }
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
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onReceive(viewModel.$isSuccess, perform: navigate(isSuccess:))
        .disabled(viewModel.state == .loading)
        .background(.white)
        .padding(.top, 30)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    
    private func forgetPasswordAction() {
        submitButton = true
        if viewModel.isValidForm(){
            let newPassword = ChangePasswordRequest(password: self.password.convertArabicNumberToEnglishNumber(), confirmPassword: self.confirmNewPassword.convertArabicNumberToEnglishNumber())
            viewModel.changePassword(request: newPassword)
        }
    }
    
    func navigate(isSuccess:Bool) {
        if isSuccess {
            pilot.push(.changePasswordSuccessPage)
        }
    }
}

struct NewPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordPage()
    }
}
