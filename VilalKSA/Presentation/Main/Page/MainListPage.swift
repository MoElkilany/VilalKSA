//
//  MainListPage.swift
//  VilalKSA
//
//  Created by Elkilany on 12/03/2024.
//


import SwiftUI
import UIPilot

struct MainListPage: View {
    @StateObject var viewModel = MainViewModel()
    @EnvironmentObject var pilot: UIPilot<MainDestination>
    var mainAdsList: [MainAdsResponse] = []
    @State var state: AppState = .success
    var body: some View {
        
        VilalKSAContainer(state:$state,titlePage: R.string.localizable.main.localized, tryAgainAction: {

        },backAction:{
            pilot.pop()
        },content: {
            ScrollView(showsIndicators:false){
                VStack{
                    ForEach(self.mainAdsList){ item in
                        
                        Button {
                            pilot.push(.adsDetailsPage(id: String(item.id ?? 0 ), type: .main))
                        } label: {
                            PropertyContainerView(imageUrl: item.image ?? "" , rate: String(item.rate ?? 0), category: item.category ?? "", name: item.name ?? "" , room: item.room ?? "" , space: item.estateSpace ?? "" , price: item.price ?? "" , favourite: item.favourite ?? false , location: item.address, rental: item.rental ?? "", addOrRemoveFavouriteAction: {
                                self.viewModel.addOrRemoveFav(id: String(item.id ?? 0))
                            })
                        }
                    }
                }
            }
            .padding(.bottom,10)
        })
    }
}
