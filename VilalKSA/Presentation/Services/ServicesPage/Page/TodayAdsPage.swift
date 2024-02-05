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
            ScrollView{
                ForEach(0...2,id: \.self) { item in
                    TodayAdsCardView(todayModel: todayAdsValue(id: 1, name: "test name ", category: "Vial", image: "jjjjj", price: "200", rental: "monthly", favourite: true, room: "4", space: 120.5, rate: 2, lat: "1.232333", lon: "1.232333", address: "المنصورة", createdAt: "24 Jan"))
                }
            }
        }).onAppear(perform: {
//            viewModel.getTodayAds()
        })
        
    }
}
