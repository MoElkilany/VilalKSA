//
//  VerificationCodePage.swift
//  VilalKSA
//
//  Created by Elkilany on 14/12/2023.
//

import SwiftUI
import UIPilot

enum FocusPin {
    case  pinOne, pinTwo, pinThree, pinFour,pinFive,pinSix
}

struct VerificationCodePage: View {
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    @StateObject var viewModel = VerificationCodeViewModel()
    
    let phoneNumber: String
    let screenChecker: NavigationChecker?
    
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne  : String = ""
    @State var pinTwo  : String = ""
    @State var pinThree: String = ""
    @State var pinFour : String = ""
    @State var pinFive : String = ""
    @State var pinSix  : String = ""
    @State var isTimeFinished: Bool = false
    @State private var countdown: Int = 30
    @State private var timer: Timer? = nil
    
    var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width
            
            ZStack {
                
                
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
                    .padding(.horizontal, width / 25)
                    .padding(.bottom, 20)
                    
                    TextBold20(textKey: R.string.localizable.verify_Your_Phone_Number.localized, textColor: R.color.colorPrimary.name.getColor())
                        .padding(.bottom,8)
                        .padding(.horizontal,4)
                    
                    TextRegular14(textKey: R.string.localizable.sent_Verification_Code_To_Phone.localized,textColor: R.color.color7A869A.name.getColor())
                        .padding(.bottom,2)
                        .padding(.horizontal,4)
                    
                    TextRegular14(textKey: self.phoneNumber.localizedKey ,textColor: R.color.color172B4D.name.getColor())
                        .padding(.bottom,2)
                    
                        .padding(.horizontal,4)
                    
                    
                    Button(action: {
                        if isTimeFinished {
                            var status = "0"
                            switch screenChecker{
                            case .isFromSignUp:
                                status = "1"
                            case .isForgetPassword:
                                status = "0"
                            case .none:
                                return
                            }
                            
                            let resendCodeRequest = ResendCodeRequest(phone: self.phoneNumber, status: status)
                            viewModel.resendCode(request: resendCodeRequest)
                            countdown = 30
                            isTimeFinished = false
                            startCountdown()
                        }
                        
                    }, label: {
                        TextBold14(textKey: isTimeFinished ?  R.string.localizable.resend_Code.localized : " 00:\(countdown) "  ,textColor: R.color.colorPrimary.name.getColor())
                            .padding(.bottom,2)
                            .padding(.horizontal,4)
                        
                    })
                    .disabled(!isTimeFinished)
                    .onAppear {
                        startCountdown()
                    }
                    .onDisappear {
                        stopCountdown()
                    }
                    
                    HStack {
                        TextField("", text: $pinOne)
                            .modifier(OtpModifer(pin:$pinOne))
                            .onChange(of: pinOne){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinTwo
                                }
                            }
                            .focused($pinFocusState, equals: .pinOne)
                        
                        TextField("", text:  $pinTwo)
                            .modifier(OtpModifer(pin:$pinTwo))
                            .onChange(of:pinTwo){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinThree
                                }else {
                                    if (newVal.count == 0) {
                                        pinFocusState = .pinOne
                                    }
                                }
                            }
                            .focused($pinFocusState, equals: .pinTwo)
                        
                        TextField("", text:$pinThree)
                            .modifier(OtpModifer(pin:$pinThree))
                            .onChange(of:pinThree){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinFour
                                }else {
                                    if (newVal.count == 0) {
                                        pinFocusState = .pinTwo
                                    }
                                }
                            }
                            .focused($pinFocusState, equals: .pinThree)
                        
                        TextField("", text:$pinFour)
                            .modifier(OtpModifer(pin:$pinFour))
                            .onChange(of:pinFour){ newVal in
                                
                                if (newVal.count == 1) {
                                    pinFocusState = .pinFive
                                }else {
                                    if (newVal.count == 0) {
                                        pinFocusState = .pinThree
                                    }
                                }
                            }
                            .focused($pinFocusState, equals: .pinFour)
                        
                        
                        TextField("", text:$pinFive)
                            .modifier(OtpModifer(pin:$pinFive))
                            .onChange(of:pinFive){ newVal in
                                
                                if (newVal.count == 1) {
                                    pinFocusState = .pinSix
                                }else {
                                    if (newVal.count == 0) {
                                        pinFocusState = .pinFour
                                    }
                                }
                            }
                            .focused($pinFocusState, equals: .pinFive)
                        
                        
                        TextField("", text:$pinSix)
                            .modifier(OtpModifer(pin:$pinSix))
                            .onChange(of:pinSix){ newVal in
                                if (newVal.count == 0) {
                                    pinFocusState = .pinFive
                                }
                            }
                            .focused($pinFocusState, equals: .pinSix)
                        
                    }
                    .padding(.vertical,12)
                    
                    DefaultButton(title: R.string.localizable.verify.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        if pinOne.isEmpty || pinTwo.isEmpty || pinThree.isEmpty || pinFour.isEmpty || pinFive.isEmpty || pinSix.isEmpty {
                            viewModel.errorMessage = R.string.localizable.invalid_Code.localized
                            viewModel.errorPopUp = true
                            return
                        }
                        let code = (pinOne) + (pinTwo) + (pinThree) + (pinFour) + (pinFive)  + (pinSix)
                        let checkCode = VerificationCodeRequest(code: code,phone:self.phoneNumber )
                        let checkCodeForgetPassword = CodeForgetPasswordRequest(phone:self.phoneNumber, code: code )
                        
                        switch screenChecker {
                        case .isForgetPassword:
                            viewModel.codeForgetPassword(request:checkCodeForgetPassword)
                        case .isFromSignUp:
                            viewModel.verificationCode(request:checkCode)
                        case .none:
                            return
                        }
                        
                        
                    }, fontWeight: .bold)
                    .padding(.top ,25)
                    
                    Spacer()
                    Image(R.image.houseSearchinIcon)
                        .padding(.bottom,10)
                        .frame(width: 255, height: 127, alignment: .center)
                }
                if viewModel.state == .loading {
                    OnScreenLoading
                }
            }
            .onAppear(){
                print("the phone number is \(self.phoneNumber)")
                print("the token is on verificarion code  :- " ,UserDefaults.standard.string(forKey: Constants.beraerToken.rawValue) ?? "")
            }
        }
        
        .popup(isPresented: $viewModel.successBottomSheet) {
            ToastBottomSecond(title: "تم إعادة الإرسال", subTitle: viewModel.successTitle)
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .autohideIn(5)
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
        .onReceive(viewModel.$userStatus, perform: navigateTo(userStatus:))
        .disabled(viewModel.state == .loading )
        .background(.white)
        .padding(.top, 40)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    
    private func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                stopCountdown()
                isTimeFinished = true
            }
        }
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
    }
}

extension VerificationCodePage {
    func navigateTo(userStatus: UserStatus ) {
        
        switch userStatus {
            
        case .none:
            return
        case .isNotVerified:
            pilot.popTo(.login)
        case .isNotCompeletProfile:
            
            switch screenChecker {
            case .isForgetPassword:
                pilot.push(.newPassword)
            case .isFromSignUp:
                pilot.push(.compeletProfilePage)
            case .none:
                return
            }
            
        case .isLogin:
            return
        }
    }
}


struct VerificationCodePage_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCodePage(phoneNumber: "01009986028", screenChecker: .isForgetPassword)
    }
}
