//
//  PrivacyPolicyPage.swift
//  VilalKSA
//
//  Created by Elkilany on 09/02/2024.
//


import SwiftUI
import UIPilot

struct PrivacyPolicyPage: View {
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    @State var state: AppState = .success
    var type :PoliciesAndProcedures = .Policie
    
    var body: some View {

        VilalKSAContainer(state: $state,titlePage:type == .Policie ? R.string.localizable.policies.localized : R.string.localizable.procedures.localized , tryAgainAction: nil,backAction:{
            pilot.pop()
        },content: {
            VStack {
                Image(R.image.options_Logo.name)
                    .resizable()
                    .frame(height: 200)
                ScrollView{
                    TextBold16(textKey:type == .Policie ? R.string.localizable.policies_Description.localized : R.string.localizable.procedures_Description.localized, textColor: R.color.color7A869A.name.getColor())
                        .padding(12)
                        .customCardStyle()
                }
            }
       
        })
        .ignoresSafeArea(.all)
        .padding(.bottom,50)
    }
}

enum PoliciesAndProcedures {
    case Policie, Procedure
}
