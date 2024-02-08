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
                    PropertyContainerView(imageUrl: item.image ?? "" , rate: String(item.rate ?? 0), category: item.category ?? "", name: item.name ?? "" , room: item.room ?? "" , space: String(item.space ?? 0), price: item.price ?? "" , favourite: item.favourite ?? false , location: item.address, rental: item.rental ?? "" )
                }
            }
        }).onAppear(perform: {
            viewModel.getTodayAds()
        })
        
    }
}
