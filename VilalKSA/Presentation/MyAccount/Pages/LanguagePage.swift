//
//  LanguagePage.swift
//  VilalKSA
//
//  Created by Elkilany on 09/02/2024.
//

import SwiftUI
import UIPilot
import LanguageManagerSwiftUI

struct LanguagePage: View {
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    @State var state: AppState = .success
    
    @State private var isSelectedArabic = UserDefaults.standard.bool(forKey:UserDefaultKeys.isSelectedArabicKey.rawValue)
    @State private var isSelectedEnglish = UserDefaults.standard.bool(forKey:UserDefaultKeys.isSelectedEnglishKey.rawValue)
    @EnvironmentObject var languageSettings: LanguageSettings
    
    
    var body: some View {
        
        VilalKSAContainer(state: $state,titlePage: R.string.localizable.language.localized, tryAgainAction: nil,backAction:{
            pilot.pop()
        },content: {

            VStack{
                LanguageSelectionButton(title: R.string.localizable.arabic.localized, imageName: R.image.ksa_logo.name, isSelected: isSelectedArabic,actionButton: {
                    isSelectedArabic = true
                    isSelectedEnglish = false
                    
                    UserDefaults.standard.set(true, forKey:UserDefaultKeys.isSelectedArabicKey.rawValue)
                    UserDefaults.standard.set(false, forKey:UserDefaultKeys.isSelectedEnglishKey.rawValue)
                    UserDefaults.standard.set("ar", forKey: UserDefaultKeys.currentLanguage.rawValue)

                })
                .padding(.bottom,15)
                LanguageSelectionButton(title: R.string.localizable.english.localized, imageName: R.image.usd_logo.name, isSelected: isSelectedEnglish, actionButton: {
                    isSelectedArabic = false
                    isSelectedEnglish = true
                    
                    UserDefaults.standard.set(false, forKey:UserDefaultKeys.isSelectedArabicKey.rawValue)
                    UserDefaults.standard.set(true, forKey:UserDefaultKeys.isSelectedEnglishKey.rawValue)
                    UserDefaults.standard.set("en", forKey: UserDefaultKeys.currentLanguage.rawValue)

                })
                Spacer().frame(height: 30)
                DefaultButton(title:  R.string.localizable.save.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                    if isSelectedArabic == true  {
                        withAnimation {
                            languageSettings.selectedLanguage = .ar
                        }
                    }else{
                        withAnimation {
                            languageSettings.selectedLanguage = .en
                        }
                    }
                }, fontWeight: .bold)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .background(RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
            
        
           
        })
        .ignoresSafeArea(.all)
        .padding(.bottom,50)
    }
}

#Preview {
    AboutAppPage()
}

