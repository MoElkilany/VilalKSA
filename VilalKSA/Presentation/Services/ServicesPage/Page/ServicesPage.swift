//
//  ServicesPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI

struct ServicesPage: View {
    
    @StateObject var viewModel = ServicesViewModel()

    var body: some View {
        
        VStack{
            TextBold16(text: R.string.localizable.services.localized, textColor: R.color.colorPrimary.name.getColor())
            
            TextBold16(text: LocalizedStringKey(viewModel.servicesList.first?.name ?? ""), textColor: R.color.colorPrimary.name.getColor())
            GridView()
        }
        .padding(.top,50)
        .padding(.bottom,30)
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            viewModel.getServices()
            print("the services array is \(viewModel.servicesList)")
        })
    }
}

#Preview {
    ServicesPage()
}
