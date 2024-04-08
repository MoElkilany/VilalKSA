//
//  ShowCardDetailsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 02/04/2024.
//

import SwiftUI
import UIPilot


struct ShowCardDetailsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    
    @StateObject var viewModel = AddPersonalCardViewModel()
    
    @State var state: AppState = .success
    var navigationType: AdDetailsTypes
    var editModel: ShowPaymentModel?
    @State var popups = DialogState()
    
    @State private var submitButton = false
    @State private var ownerCardName: String = ""
    @State private var cardNumber: String = ""
    @State private var endDate: String = ""
    @State private var cvv: String = ""
    @State private var id: String = ""
    
    var body: some View {
        VilalKSAContainer(state: self.$state,titlePage:  R.string.localizable.show_Card_Details.localized, tryAgainAction: {
            
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
                            .disabled(true)
                        }
                        
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.card_Number.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                                .padding(.leading)
                            VilalTextField(text: $cardNumber, placeholder:  R.string.localizable.card_Placeholder.localized, imageName:"" , keyboardType: .asciiCapableNumberPad, validationInput: .cardNumber, submitButton: submitButton, onSubmit: { isValid in
                                self.viewModel.isCardNumberValid = isValid
                            })
                            .disabled(true)
                        }
                        
                        HStack{
                            VStack(alignment: .leading,spacing: 0) {
                                TextBold14(textKey: R.string.localizable.expiration_Date.localized, textColor: R.color.colorPrimary.name.getColor())
                                    .padding(.bottom,0)
                                    .padding(.leading)
                                VilalTextField(text: $endDate, placeholder:  R.string.localizable.expiration_Date_Placeholder.localized, imageName:"" , keyboardType: .numbersAndPunctuation, validationInput: .expireDate, submitButton: submitButton, onSubmit: { isValid in
                                    self.viewModel.isEndDateValid = isValid
                                })
                                .disabled(true)
                            }
                            
                            VStack(alignment: .leading,spacing: 0) {
                                TextBold14(textKey: R.string.localizable.cvV.localized, textColor: R.color.colorPrimary.name.getColor())
                                    .padding(.bottom,0)
                                    .padding(.leading)
                                VilalTextField(text: $cvv, placeholder:  R.string.localizable.cvV.localized, imageName:"" , keyboardType: .asciiCapableNumberPad, validationInput: .cvvNumber, submitButton: submitButton, onSubmit: { isValid in
                                    self.viewModel.isCVValid = isValid
                                })
                                .disabled(true)
                            }
                        }
                        
                        
                        DefaultButton(title: R.string.localizable.book.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        popups.middleItem = SomeItem(mainTitle: R.string.localizable.complete_Booking_Process.localized, subTitle: nil, image: nil)
                            
                        }, fontWeight: .bold)
                        .padding(.vertical,20)
                    }
                    .padding()
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

        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        .disabled(self.viewModel.state == .loading )
        
        .popup(item: $popups.middleItem) { item in
            PopupMiddle(item: item) {
                popups.middleItem = nil
            }
        } customize: {
            $0
                .closeOnTapOutside(true)
                .closeOnTap(true)
                .backgroundColor(.black.opacity(0.3))
        }
    }
}


