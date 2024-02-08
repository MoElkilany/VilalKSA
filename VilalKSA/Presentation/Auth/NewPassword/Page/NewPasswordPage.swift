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
                    
                    ScrollView(showsIndicators:false){
                        HStack {
                            VStack(alignment: .leading) {
                                TextExtraBold16(text: "Create New Password", textColor: R.color.color172B4D.name.getColor())
                                    .padding(.bottom,1)
                                TextRegular12(text: "The new password must be different from the one previously used", textColor: R.color.color7A869A.name.getColor())
                            }
                            Spacer()
                        }
                        .padding([.vertical ,.horizontal],22)
                        
                        
                        
                        PasswordTextField(text: $password, keyboardType: .default, placeholder: "Password", validationClosure: { input in
                            let letterCount = input.filter { $0.isLetter }.count
                            let digitCount = input.filter { $0.isNumber }.count
                            return  letterCount >= 8 || digitCount >= 8
                        }
                        ).padding(.top,12)
                        
                        
                        PasswordTextField(text: $confirmNewPassword, keyboardType: .default, placeholder: "Re-enter the password", validationClosure: { input in
                            let letterCount = input.filter { $0.isLetter }.count
                            let digitCount = input.filter { $0.isNumber }.count
                            return  letterCount >= 8 || digitCount >= 8
                        }
                        )
                        .padding(.top,12)
                        .padding(.bottom, 20)
                        
                        
                        
                        DefaultButton(title: "Reset Password", backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                            forgetPasswordAction()
                        }, fontWeight: .bold)
                    }
                }
                
                if viewModel.state == .loading {
                    OnScreenLoading
                }
            }
        }
        .popup(isPresented: $viewModel.errorPopUp) {
            ErrorToast(title: LocalizedStringKey(viewModel.errorMessage))
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
        guard viewModel.validatePasswords(self.password, self.confirmNewPassword) else {
            return
        }
        
        let newPassword = ChangePasswordRequest(password: self.password, confirmPassword: self.confirmNewPassword)
        viewModel.changePassword(request: newPassword)
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
