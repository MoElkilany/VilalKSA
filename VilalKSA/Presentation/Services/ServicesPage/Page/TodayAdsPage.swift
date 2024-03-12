//
//  TodayAdsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 31/01/2024.
//

import SwiftUI
import UIPilot

struct TodayAdsPage: View {
    
    @StateObject var viewModel = TodayAdsViewModel()
    @EnvironmentObject var pilot: UIPilot<ServicesDestination>
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.todays_Ads.localized, tryAgainAction: {
            viewModel.getTodayAds()
        },backAction:{
            pilot.pop()
        } ,content: {
            ScrollView(showsIndicators:false){
                ForEach(viewModel.todayAdsList,id: \.id) { item in
                    Button {
                        pilot.push(.adsDetailsPage(id: String(item.id ?? 0), type: .toDaysAds ))
                    } label: {
                        PropertyContainerView(imageUrl: item.image ?? "" , rate: String(item.rate ?? 0), category: item.category ?? "", name: item.name ?? "" , room: item.room ?? "" , space: item.estateSpace ?? "" , price: item.price ?? "" , favourite: item.favourite ?? false , location: item.address, rental: item.rental ?? "", addOrRemoveFavouriteAction: {
                            self.viewModel.addOrRemoveFav(id: String(item.id ?? 0 ))
                        })
                    }
                }
               
            }
            .padding(.bottom,22)
        }).onAppear(perform: {
            viewModel.getTodayAds()
        })
        
    }
}
