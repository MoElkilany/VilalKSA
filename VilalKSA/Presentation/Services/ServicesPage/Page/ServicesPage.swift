//
//  ServicesPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI
import UIPilot

struct PopupsState {
    var middleItem: SomeItem?
}

struct ServicesPage: View {
    
    @EnvironmentObject var pilot: UIPilot<ServicesDestination>
    @StateObject var viewModel = ServicesViewModel()
    @State var popups = PopupsState()
    
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.services.localized, tryAgainAction: {
            viewModel.getServices()
        },backAction:nil ,content: {
            VStack{
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.servicesList,id: \.id) { item in
                        GridViewItem(icon: item.icon ?? "", title: item.name ?? "") {
                            if item.id == 2 {
                                pilot.push(.customeRequest)
                            }else if item.id == 4 {
                                pilot.push(.todayAdsPage)
                            }else{
                                popups.middleItem = SomeItem(mainTitle: LocalizedStringKey( item.name ?? ""), subTitle: nil, image: nil)
                                
                            }
                        }
                    }
                }
            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.top)
        .onAppear(perform: {
            viewModel.getServices()
            print("the services array is \(viewModel.servicesList)")
        })
        
        .popup(item: $popups.middleItem) { item in
            PopupMiddle(item: item) {
                popups.middleItem = nil
            }
        } customize: {
            $0
                .closeOnTap(true)
                .backgroundColor(.black.opacity(0.5))
        }
    }
}

#Preview {
    ServicesPage()
}

