//
//  AddPersonalCardPage.swift
//  VilalKSA
//
//  Created by Elkilany on 19/03/2024.
//

import SwiftUI
import UIPilot


struct AddPersonalCardPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    
    @StateObject var viewModel = AddPersonalCardViewModel()
    
    @State var state: AppState = .success
    var navigationType: AdDetailsTypes
    var editModel: ShowPaymentModel?
    
    @State private var submitButton = false
    @State private var ownerCardName: String = ""
    @State private var cardNumber: String = ""
    @State private var endDate: String = ""
    @State private var cvv: String = ""
    @State private var id: String = ""
    
    var body: some View {
        VilalKSAContainer(state: self.$state,titlePage: editModel == nil ? R.string.localizable.add_The_Card.localized : R.string.localizable.edit_Card.localized, tryAgainAction: {
            
        },backAction:{
            switch navigationType {
            case .ads:
                pilot.pop()
            case .main:
                mainPilot.pop()
            case .toDaysAds:
                servicesPilot.pop()
            case .favorite:
                favoritePilot.pop()
            }
        },content: {
            ZStack{
                ScrollView(showsIndicators:false){
                    VStack(alignment: .leading){
                        
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.cardholder_Name.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                                .padding(.leading)
                            VilalTextField(text: $ownerCardName, placeholder:  R.string.localizable.cardholder_Name.localized, imageName:"" , keyboardType: .default, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                self.viewModel.isOwnerCardNameValid = isValid
                            })
                        }
                        
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.card_Number.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                                .padding(.leading)
                            VilalTextField(text: $cardNumber, placeholder:  R.string.localizable.card_Placeholder.localized, imageName:"" , keyboardType: .asciiCapableNumberPad, validationInput: .cardNumber, submitButton: submitButton, onSubmit: { isValid in
                                self.viewModel.isCardNumberValid = isValid
                            })
                        }
                        
                        HStack{
                            VStack(alignment: .leading,spacing: 0) {
                                TextBold14(textKey: R.string.localizable.expiration_Date.localized, textColor: R.color.colorPrimary.name.getColor())
                                    .padding(.bottom,0)
                                    .padding(.leading)
                                VilalTextField(text: $endDate, placeholder:  R.string.localizable.expiration_Date_Placeholder.localized, imageName:"" , keyboardType: .numbersAndPunctuation, validationInput: .expireDate, submitButton: submitButton, onSubmit: { isValid in
                                    self.viewModel.isEndDateValid = isValid
                                })
                            }
                            
                            VStack(alignment: .leading,spacing: 0) {
                                TextBold14(textKey: R.string.localizable.cvV.localized, textColor: R.color.colorPrimary.name.getColor())
                                    .padding(.bottom,0)
                                    .padding(.leading)
                                VilalTextField(text: $cvv, placeholder:  R.string.localizable.cvV.localized, imageName:"" , keyboardType: .asciiCapableNumberPad, validationInput: .cvvNumber, submitButton: submitButton, onSubmit: { isValid in
                                    self.viewModel.isCVValid = isValid
                                })
                            }
                        }
                        
                        
                        DefaultButton(title: editModel == nil ? R.string.localizable.add.localized : R.string.localizable.edit.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                            submitButton = true
                            if viewModel.isValidForm(){
                                let AddPayment = AddPaymentRequestModel(name: ownerCardName, number: cardNumber, cvv: cvv, date: endDate)
                                if editModel != nil {
                                    viewModel.editCard(id: self.id, requestModel: AddPayment)
                                }else{
                                    viewModel.addCard(requestModel: AddPayment)
                                }
                            }
                            
                        }, fontWeight: .bold)
                        .padding(.vertical,20)
                    }
                    .padding()
                }
                .disabled(self.viewModel.state == .loading)
                .disabled(self.viewModel.isSucess == true )
                if self.viewModel.state == .loading {
                    OnScreenLoading
                }
            }
            .onAppear {
                if editModel != nil {
                    id = editModel?.id ?? ""
                    ownerCardName = editModel?.name ?? ""
                    cardNumber = editModel?.number ?? ""
                    endDate = editModel?.date ?? ""
                    cvv = editModel?.cvv ?? ""
                }
            }
        })
        .popup(isPresented: $viewModel.isSucess) {
            ToastBottomSecond(title: R.string.localizable.success.localized , subTitle: nil ,subTitleLocalized: viewModel.isEditSucess == true ? R.string.localizable.edit_Sucess.localized : R.string.localizable.card_Added_Successfully.localized)
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .autohideIn(5)
        }
        
        .onReceive(viewModel.$isSucess, perform: { isSucess in
            if isSucess == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    switch navigationType {
                    case .ads:
                        pilot.pop()
                    case .main:
                        mainPilot.pop()
                    case .toDaysAds:
                        servicesPilot.pop()
                    case .favorite:
                        favoritePilot.pop()
                    }
                }
            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        .disabled(self.viewModel.state == .loading )
    }
}



#Preview {
    AddPersonalCardPage(navigationType: .main)
}


struct ShowPaymentModel: BaseModel {
    var id:String
    var name: String
    var number: String
    var cvv: String
    var date: String
}

