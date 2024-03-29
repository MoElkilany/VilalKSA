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

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Vilal KSA")
        
        return true
    }
}

@main
struct VilalKSAApp: App {
    
    @StateObject var networkMonitor = NetworkMonitor()
    @EnvironmentObject var languageSettings: LanguageSettings

    // inject into SwiftUI life-cycle via adaptor !!!
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LanguageManagerView(.ar) {
                UIPilotHost(checkToken()) { route in
                    route.view
                        .transition(.slide)
                        .navigationBarHidden(false)
                        .navigationBarBackButtonHidden(false)
                        .uipNavigationBarHidden(true)
                        .ignoresSafeArea()
                }
            }
            .ignoresSafeArea()
            .environmentObject(networkMonitor)
        }
        
    }
    
    func checkToken() -> UIPilot<RootDestination> {

        if let _ = UserDefaults.standard.string(forKey: Constants.beraerToken.rawValue) {
            return UIPilot<RootDestination>(initial: .home)
        } else {
            return UIPilot<RootDestination>(initial: .splash)
        }
    }
    
}
