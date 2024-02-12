//
//  MainPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        VStack{
            Image(R.image.home_Placeholder.name)
                .resizable()
        }
        .ignoresSafeArea(.all)
    }
    
}

#Preview {
    MainPage()
}
