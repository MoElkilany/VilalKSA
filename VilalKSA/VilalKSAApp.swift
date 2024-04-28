//
//  VilalKSAApp.swift
//  VilalKSA
//
//  Created by Elkilany on 20/11/2023.
//

import SwiftUI
import UIKit
import LanguageManagerSwiftUI
import UIPilot
import GoogleMaps
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
        GMSServices.provideAPIKey("AIzaSyBocCCwfAulH7Gso8pfLITItdePia30c1U")
        GMSPlacesClient.provideAPIKey("AIzaSyBocCCwfAulH7Gso8pfLITItdePia30c1U")
        return true
    }
}




@main
struct VilalKSAApp: App {
    @EnvironmentObject var languageSettings: LanguageSettings

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    private var hasLaunchedBefore: Bool {
        UserDefaults.standard.bool(forKey: Constants.hasLaunchedBefore.rawValue)
    }
    
    var body: some Scene {
        WindowGroup {
                LanguageManagerView(.ar) {
                    UIPilotHost(checkToken()) { route in
                        AppLoader {
                            route.view
                                .transition(.slide)
                                .uipNavigationBarHidden(true)
                        }
                    }
                }
                .ignoresSafeArea()
        }
    }
    
    func checkToken() -> UIPilot<RootDestination> {
        if hasLaunchedBefore {
            if UserDefaults.standard.bool(forKey: Constants.isLogin.rawValue) {
                return UIPilot<RootDestination>(initial: .home)
            } else {
                return UIPilot<RootDestination>(initial: .login)
            }
        }else{
            return UIPilot<RootDestination>(initial: .onboarding)
        }
    }
}

