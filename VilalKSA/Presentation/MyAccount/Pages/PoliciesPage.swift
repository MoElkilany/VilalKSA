//
//  PoliciesPage.swift
//  VilalKSA
//
//  Created by Elkilany on 31/03/2024.
//


import SwiftUI
import UIPilot


struct PoliciesPage: View {

    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    @State var state: AppState = .success
    let columns: [GridItem] = [
           GridItem(.flexible(), spacing: 20),
           GridItem(.flexible())     ]

    var body: some View {

        VilalKSAContainer(state: self.$state,titlePage: R.string.localizable.policiesAndProcedures.localized, tryAgainAction: nil ,backAction:{
            pilot.pop()
        } ,content: {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 30) {
                    
                    ImageWithBottomTextGridView(title: R.string.localizable.policies.localized, image: R.image.policies.name, action: {
                        pilot.push(.privacyPolicy(type: .Policie))
                    })
                    
                    ImageWithBottomTextGridView(title: R.string.localizable.procedures.localized, image: R.image.procedures.name, action: {
                        pilot.push(.privacyPolicy(type: .Procedure))
                    })
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
        })
            
     
    }
}




struct ImageWithBottomTextGridView: View {
    var title: LocalizedStringKey
    var image: String
    var action: (() -> ())?
    
    var body: some View {
        Button(action: {
            self.action?()
        }, label: {
            VStack {
                ZStack {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.vertical, 40)
                }
                Spacer()
                
                HStack
                {
                    TextRegular16(textKey: title,textColor: Color.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    R.color.colorPrimary.name.getColor().opacity(5.0)
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .background(R.color.colorF7F8F8.name.getColor())
            .cornerRadius(12)
        })
        
    }
}





