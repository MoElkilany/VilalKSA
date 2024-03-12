//
//  FavoritesPage.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import SwiftUI
import UIPilot

struct FavoritesPage: View {
    @StateObject var viewModel = FavoritesViewModel()
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    @State private var searchText = ""
    @State var showfilterSheet: Bool = false
    @State var filterResult: LocalizedStringKey = ""

    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.favorites.localized, tryAgainAction: {
                        viewModel.getFav()
        },backAction:{
            pilot.pop()
        },haveAnotherButton: true ,buttonAction:{
            showfilterSheet = true
        },iconButton: R.image.more_Circle.name ,content: {
            ScrollView(showsIndicators:false){
                VStack{
                    HStack {
                        TextField(R.string.localizable.search.localized, text: $searchText)
                            .padding(8)
                            .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
                            .padding(.horizontal, 24)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                HStack {
                                    
                                    Button(action: {
                                        print("make search")
                                    }, label: {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                            .padding(.trailing, 8)
                                    })
                                }
                            )
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                TextRegular12(textKey:R.string.localizable.cancel.localized,textColor: R.color.colorPrimary.name.getColor())
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    .frame(height: 50)
                    .padding(.horizontal)
                    
                    HStack{
                        HStack(spacing:2){
                            TextBold14(text:String(self.viewModel.favoriteList?.count ?? 0), textColor: R.color.color172B4D.name.getColor())
                            TextBold14(textKey: R.string.localizable.adS.localized, textColor: R.color.color172B4D.name.getColor())
                        }
                        Spacer()
                        TextRegular12(textKey:self.filterResult, textColor: R.color.color42526E.name.getColor())
                    }
                    .padding(.horizontal,20)
                    
                    ForEach(self.viewModel.favoriteList ?? [], id: \.self ) { item in
                        PropertyContainerView(imageUrl: item.image ?? "" , rate: String(item.rate ?? 0), category: item.category ?? "" , name: item.name ?? "" , room: item.room ?? "", space: String(item.space ?? 0) , price: item.price ?? "" , favourite: item.favourite ?? false, location: item.address ?? "", rental: item.rental ?? "", addOrRemoveFavouriteAction: {
                            self.viewModel.addOrRemoveFav(id: String(item.id ?? 0))
                        })
                    }
                }
            }
        })
        .actionSheet(isPresented: $showfilterSheet) {
            ActionSheet(
                title: Text(R.string.localizable.choose_Option.localized),
                message: nil,
                buttons: [
                    .default(Text(R.string.localizable.the_Nearest.localized)) {
                        self.filterResult = R.string.localizable.the_Nearest.localized
                        showfilterSheet = false
                    },
                    .default(Text(R.string.localizable.farthest.localized)) {
                        self.filterResult = R.string.localizable.farthest.localized
                        showfilterSheet = false
                    },
                    .cancel()
                ])
        }
        .ignoresSafeArea(.all)
        .padding(.bottom,30)
        .task {
            viewModel.getFav()
        }
        
    }
}
