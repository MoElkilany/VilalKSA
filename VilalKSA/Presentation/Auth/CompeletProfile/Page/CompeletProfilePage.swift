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
    
    var body: some View {
        ZStack{
            VStack{
                ScrollView{
                    TextBold16(text: "Completing Personal Profile Information", textColor: R.color.color172B4D.name.getColor())
                        .padding(.vertical,12)
                        .padding(.top,42)
                    
                    VStack(spacing:30) {
                        GeneralTextField(
                            text: $firstName,
                            placeholder: "Enter First name",
                            imageName: R.image.profileIcon.name ,
                            keyboardType: .default ,
                            validationClosure: { input in
                                let letterCount = input.filter { $0.isLetter }.count
                                return letterCount >= 3
                            }
                        )

                        GeneralTextField(
                            text: $secondName,
                            placeholder: "Enter Second name",
                            imageName: R.image.profileIcon.name ,
                            keyboardType: .default ,
                            validationClosure: { input in
                                let letterCount = input.filter { $0.isLetter }.count
                                return letterCount >= 3
                            }
                        )
                        
                        GeneralTextField(
                            text: $email,
                            placeholder: "Enter Email",
                            imageName: R.image.emailIcon.name ,
                            keyboardType: .emailAddress ,
                            validationClosure: { input  in
                                let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
                                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
                                return emailPredicate.evaluate(with: input)
                            }
                        )
                        
                        PasswordTextField(text: $password,
                                          keyboardType: .default ,
                                          placeholder: "Password", validationClosure: { input  in
                            let letterCount = input.filter { $0.isNumber }.count
                            return letterCount >= 6
                        })
                        
                        PasswordTextField(text: $rewritePassword,keyboardType: .default ,
                                          placeholder: "Rewrite Password", validationClosure: { input  in
                            let letterCount = input.filter { $0.isNumber }.count
                            return letterCount >= 6
                        })
                        
                    }
                    .padding(.horizontal,2)
                    
                    
                }
                
                DefaultButton(title: "Create Account", backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                    createAccount()
                }, fontWeight: .bold)
                .padding(.bottom, 30)
            }
           
            if viewModel.state == .loading {
                OnScreenLoading
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

        .popup(isPresented: $viewModel.successBottomSheet) {
            ToastBottomSecond(title: "Successfully registered", subTitle: viewModel.successTitle)
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
            guard viewModel.validateFields(firstName: firstName, secondName: secondName, email: email, password: password, rewritePassword: rewritePassword) else {
                return
            }
            
            let completeProfileModel = CompleteProfileModelRequest(firstName: firstName, secondName: secondName, email: email, password: password, confirmPassword: rewritePassword)
            viewModel.compeletProfile(request: completeProfileModel)
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


