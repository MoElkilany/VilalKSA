//
//  MyReservationsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//

import SwiftUI
import UIPilot

struct MyReservationsPage: View {
    
    @StateObject var viewModel = MyReservationsViewModel()
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    
    @State private var selectedTabIndex = 0
    let tabs = ["Tab 1", "Tab 2", "Tab 3"]
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.my_Reservations.localized, tryAgainAction: {
            //            viewModel.getTodayAds()
        },backAction:{
            pilot.pop()
        },content: {
            VStack {
                MyReservationHeaderTabsView(selection: $selectedTabIndex)
                TabView(selection: $selectedTabIndex) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        MyReservationTypesView(myReservationTypes: MyReservationTypes(rawValue: index) ?? .onGoing )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }


        })
        .ignoresSafeArea(.all)
        .padding(.bottom,50)
    }
}
