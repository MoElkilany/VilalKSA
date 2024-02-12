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
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.favorites.localized, tryAgainAction: {
            //            viewModel.getTodayAds()
        },backAction:{
            pilot.pop()
        },haveAnotherButton: true ,buttonAction:{
            print("Hello")
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
                                TextRegular12(text:R.string.localizable.cancel.localized,textColor: R.color.colorPrimary.name.getColor())
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    .frame(height: 50)
                    .padding(.horizontal)
                    
                    
                    
                    HStack{
                        HStack(spacing:2){
                            TextBold14(text:"4", textColor: R.color.color172B4D.name.getColor())
                            TextBold14(text: R.string.localizable.adS.localized, textColor: R.color.color172B4D.name.getColor())
                        }
                        Spacer()
                        TextRegular12(text: "الاقرب", textColor: R.color.color42526E.name.getColor())
                        
                    }
                    .padding(.horizontal,20)
                    
                    ForEach(0..<10, id: \.self ) { item in
                        PropertyContainerView(imageUrl: "https://verasign.se/ammr/public/assets/images/faces/1.jpg", rate: "4.5", category: "فيلا للبيع", name: "فيلا ميت غراب", room: "4", space: "120", price: "2400", favourite: true, location: "المنصورة ", rental: "شهري")
                    }
                }
                //                ForEach(viewModel.todayAdsList,id: \.id) { item in
                
            }
        })
        .ignoresSafeArea(.all)
        .padding(.bottom,30)
        .onAppear(perform: {
            //            viewModel.getTodayAds()
        })
        
    }
}
