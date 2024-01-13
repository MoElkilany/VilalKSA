#  how can use most of my modifiers 




import SwiftUI
import UIPilot
import PopupView

struct PopupsState {
    var middleItem: SomeItem?
    var showingTopFirst = false
}

struct LoginPage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State var showError: Bool = false
    @State var popups = PopupsState()
    @State var showingPopup = false
    
    var body: some View {
        
        ScrollView {
            
            VStack{
                TextExtraBold16(text: "Hello World", textColor: .blue)
                TextExtraBold20(text: "Hello World", textColor: .blue)
                TextExtraBold20(text: "Hello World", textColor: .blue)
                TextExtraBold20(text: "Hello World", textColor: .blue)
                TextExtraBold20(text: "Hello World", textColor: .blue)
                TextExtraBold20(text: "Hello World", textColor: .blue)
                TextExtraBold20(text: "Hello World", textColor: .blue)
                TextExtraBold20(text: "Hello World", textColor: .blue)
            }
            
            
            
            
            VStack{
                DefaultButton(title: "Hello World", backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                    popups.showingTopFirst = true
                }, fontWeight: .semibold)
                
                DefaultButtonWithIcon(title: "Hello", icon: R.image.chat.name, actionButton: {
                })
                .frame(width: 150)
                
                DefaultBoarderButtonWithIcon(title: "Hello",borderColor: R.color.colorPrimary.name.getColor() ,borderWidth: 2,backgroundColor: .white, titleColor: .black ,actionButton: {
                })
                .frame(width: 150)
                
                //
                GeneralTextField(
                    text: $phoneNumber,
                    placeholder: "ادخل رقم الهاتف",
                    imageName: R.image.phoneIcon.name ,
                    validationClosure: { input in
                        let digitsOnly = input.allSatisfy { $0.isNumber }
                        return digitsOnly
                    }
                )
                
                PasswordTextField(
                    text: $password,
                    placeholder: "Password",
                    validationClosure: { input in
                        let digitsOnly = input.allSatisfy { $0.isNumber }
                        return digitsOnly
                    }
                )
                
                PasswordTextField(
                    text: $password,
                    placeholder: "Password",
                    validationClosure: { input in
                        let digitsOnly = input.allSatisfy { $0.isNumber }
                        return digitsOnly
                    }
                )
                
                Spacer()
            }
        }
        .padding(.vertical,50)
        .popup(isPresented: $popups.showingTopFirst) {
            ErrorToast(title: "لم يتم تسجيل ")
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .autohideIn(5)
        }
        .padding(.top, 30)
        .background(.white)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}


