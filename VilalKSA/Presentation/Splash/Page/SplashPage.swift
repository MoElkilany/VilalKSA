//
//  LoginPage.swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//

import SwiftUI
import UIPilot

struct SplashPage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    
    @State var state: AppState = .success
    
    var body: some View {
        
        VilalKSAContainer(state: $state, tryAgainAction: tryAgain,  backAction: nil, content: {
            VStack{
                Spacer()
                Image(R.image.logoIcon)
                    .resizable()
                    .frame(width: 150,height: 150)
                
                Spacer()
            }
        })
        
        .background(R.color.colorPrimary.name.getColor())
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                pilot.push(.login)
            }
        }
    }
}




extension SplashPage{
    
    func tryAgain() {
        
    }
}


