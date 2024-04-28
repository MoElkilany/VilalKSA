//
//  OnboardingPage.swift
//  VilalKSA
//
//  Created by Elkilany on 18/04/2024.
//

import SwiftUI
import UIPilot

struct OnboardingPage: View {
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingView(imageName: R.image.onboardin_Image1.name,
                           title: R.string.localizable.onboardingTitle1.localized,
                           subtitle:  R.string.localizable.onboardingSubTitle1.localized,
                           currentPage: $currentPage)
            .tag(0)
            
            OnboardingView(imageName: R.image.onboardin_Image2.name,
                           title: R.string.localizable.onboardingTitle2.localized,
                           subtitle:  R.string.localizable.onboardingSubTitle2.localized,
                           currentPage: $currentPage)
            .tag(1)
            
            OnboardingView(imageName: R.image.onboardin_Image3.name,
                           title: R.string.localizable.onboardingTitle3.localized,
                           subtitle:  R.string.localizable.onboardingSubTitle3.localized,
                           currentPage: $currentPage)
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear {
            UserDefaults.standard.set(true, forKey:  Constants.hasLaunchedBefore.rawValue)
        }
    }
}

struct OnboardingView: View {
    let imageName: String
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    @Binding var currentPage: Int
    @EnvironmentObject var pilot: UIPilot<RootDestination>
    
    var body: some View {
        VStack(spacing:20) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 30)
                .padding(.vertical,30)
            
            TextExtraBold20(textKey: title, textColor: R.color.color172B4D.name.getColor())
            TextRegular16(textKey: subtitle, textColor: R.color.color7A869A.name.getColor())
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                if currentPage != 2 {
                    withAnimation {
                        currentPage += 1
                    }
                }else{
                    pilot.push(.login)
                }}) {
                   
                        HStack{
                            Spacer()
                            if currentPage == 2 {
                                TextBold16(textKey: R.string.localizable.let_Started.localized, textColor: R.color.colorPrimary.name.getColor())
                                    .padding(.horizontal,12)

                            }else{
                                Image(R.image.circleButton.name)
                            }
                        }
                        .padding(.bottom,40)
            }
        }
        .padding(.top,100)
        .padding()
        
    }
}
