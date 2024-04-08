//
//  AddNewAdCategoryPage.swift
//  VilalKSA
//
//  Created by Elkilany on 10/02/2024.
//

import SwiftUI
import UIPilot

struct AddNewAdCategoryPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @StateObject var viewModel = AddNewAdCategoryViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.add_New_Ad.localized, tryAgainAction: {
            viewModel.getAdsCategoryList()
        },backAction:{
            pilot.pop()
        } ,content: {
            
            ScrollView{
                VStack{
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.adsCategoryList,id: \.id) { item in
                            GridViewItem(icon: item.icon ?? "", title: item.name ?? "") {
                                pilot.push(.addNewAdLocationPage(model: AddNewAdRequestModel(categoryAdID: String(item.id ?? 0) ,addStatus: item.status ?? "" )))
                            }
                        }
                    }
                }
                .padding(.vertical,30)

            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.top,20)
        .onAppear(perform: {
            if self.viewModel.adsCategoryList.isEmpty == true {
                viewModel.getAdsCategoryList()
            }
        })
    }
}
