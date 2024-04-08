//
//  MyPersonalCardsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 15/03/2024.
//

import SwiftUI
import UIPilot

struct MyPersonalCardsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    @StateObject var viewModel = MyPersonalCardsViewModel()
    
    @State var state: AppState = .success
    var navigationType: AdDetailsTypes
    
    var body: some View {
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.my_Personal_Cards.localized, tryAgainAction: {
            viewModel.getPayment()
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
        },haveAnotherButton: true ,buttonAction:{
            
            switch navigationType {
            case .ads:
                pilot.push(.addPersonalCardPage(type: navigationType))
            case .main:
                mainPilot.push(.addPersonalCardPage(type: navigationType))
            case .toDaysAds:
                servicesPilot.push(.addPersonalCardPage(type: navigationType))
            case .favorite:
                favoritePilot.push(.addPersonalCardPage(type: navigationType))
            }
            
        },iconButton: R.image.plusButton.name ,content: {
            ZStack {
                
                ScrollView(showsIndicators:false){
                    VStack(alignment: .leading){
                        TextBold14(textKey: R.string.localizable.credit_and_Debit_Cards.localized, textColor: R.color.color172B4D.name.getColor())
                        
                        ForEach(viewModel.paymentsList,id:\.self ) { item in
                            PersonalCardsView(cardName: item.name ?? " ",cardNumber:  item.number ?? " ",deleteAction: {
                                print("delete Action")
                                viewModel.deleteMyRequest(id: String(item.id ?? 0))
                                
                            } ,editAction: {
                                
                                let model = ShowPaymentModel(id: String(item.id ?? 0) ,name: item.name ?? "", number: item.number ?? "", cvv: item.cvv ?? "", date: item.date ?? "")
                                switch navigationType {
                                case .ads:
                                    pilot.push(.addPersonalCardPage(type: navigationType,model:model))
                                case .main:
                                    mainPilot.push(.addPersonalCardPage(type: navigationType,model:model))
                                case .toDaysAds:
                                    servicesPilot.push(.addPersonalCardPage(type: navigationType,model:model))
                                case .favorite:
                                    favoritePilot.push(.addPersonalCardPage(type: navigationType,model:model))
                                }
                            })
                            
                            .onTapGesture {
                                let  model = ShowPaymentModel(id: String(item.id ?? 0) ,name: item.name ?? "", number: item.number ?? "", cvv: item.cvv ?? "", date: item.date ?? "")
                                switch navigationType {
                                case .ads:
                                    pilot.push(.showCardDetailsPage(type: navigationType,model:model))
                                case .main:
                                    mainPilot.push(.showCardDetailsPage(type: navigationType,model:model))
                                case .toDaysAds:
                                    servicesPilot.push(.showCardDetailsPage(type: navigationType,model:model))
                                case .favorite:
                                    favoritePilot.push(.showCardDetailsPage(type: navigationType,model:model))
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                if self.viewModel.deleteState == .loading {
                    OnScreenLoading
                }
            }
            .popup(isPresented: $viewModel.successBottomSheet) {
                ToastBottomSecond(title: R.string.localizable.success.localized, subTitle:nil, subTitleLocalized:R.string.localizable.delete_Sucess.localized )
            } customize: {
                $0
                    .type(.floater())
                    .position(.bottom)
                    .animation(.spring())
                    .autohideIn(5)
            }
            .task {
                viewModel.getPayment()
            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
    }
}

struct PersonalCardsView: View {
    var cardName:String?
    var cardNumber:String?
    var deleteAction: (()->Void)?
    var editAction: (()->Void)?
    
    var body: some View {
        HStack{
            HStack{
                Image(R.image.myCards.name)
                    .resizable()
                    .frame(width: 35, height: 35, alignment: .center)
                
                VStack(alignment: .leading){
                    TextBold18(text: cardName ?? "0", textColor: R.color.color172B4D.name.getColor())
                    TextBold14(text:cardNumber ?? "  " ,textColor: R.color.color868583.name.getColor())
                }
                .padding(.horizontal,8)
            }
            
            
            Spacer()
            
            HStack(spacing: 8){
                Image(R.image.deleteIcon.name)
                    .resizable()
                    .frame(width: 35, height: 35, alignment: .center)
                    .onTapGesture {
                        deleteAction?()
                    }
                
                
                Image(R.image.editIcon.name)
                    .resizable()
                    .frame(width: 35, height: 35, alignment: .center)
                    .onTapGesture {
                        editAction?()
                    }
            }
        }
        .padding()
        .frame(height: 100)
        .cardStyle(corner: 15)
    }
}


struct NoCardsFoundView: View {
    
    var body: some View {
        VStack(spacing:4) {
            Image(R.image.noResult.name)
                .frame(width: 30, height: 30)
                .padding(.bottom,30)
            TextBold16(textKey: R.string.localizable.no_Cards_Found.localized, textColor: R.color.colorPrimary.name.getColor())
            DefaultBoarderButtonWithIcon(title: R.string.localizable.add_The_Card.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {})
                .frame(width: 150, height: 50)
            
        }
    }
}

