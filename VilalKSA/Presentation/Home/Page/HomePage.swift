//
//  HomePage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//
import SwiftUI
import LanguageManagerSwiftUI
import UIPilot

struct HomeScreen: View {
    
    @StateObject var tabBarSelection = TabBarSelection()
    
    @StateObject var mainPilot = UIPilot<MainDestination>(initial: .main)
    @StateObject var servicesPilot = UIPilot<ServicesDestination>(initial: .services)
    @StateObject var addRequestPilot = UIPilot<AddRequestDestination>(initial: .addRequest)
    @StateObject var favoritePilot = UIPilot<FavoritesDestination>(initial: .favorites)
    @StateObject var morePilot = UIPilot<MyAccountDestination>(initial: .myAccount)
    
    @StateObject var popupPresent = PopupPresent()
    
    var tabs = [
        TabBarItem(tag: TabBarItemType.TabBarMain, icon: R.image.main.name),
        TabBarItem(tag: TabBarItemType.TabBarService, icon: R.image.services.name),
        TabBarItem(tag: TabBarItemType.TabBarAddRequest, icon: R.image.add.name),
        TabBarItem(tag: TabBarItemType.TabBarMessage, icon: R.image.heartTap.name),
        TabBarItem(tag: TabBarItemType.TabBarMyAccount, icon: R.image.profile.name)
    ]
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $tabBarSelection.selectedTab) {
                AnyView(
                    UIPilotHost(mainPilot) { router in
                        router.view
                            .transition(.slide)
                            .uipNavigationBarHidden(true)
                            .ignoresSafeArea()
                            .environmentObject(tabBarSelection)
                    }
                ).tabItem {
                    // image
                }
                .tag(tabs[0].tag)
                .ignoresSafeArea()
                
                AnyView(
                    UIPilotHost(servicesPilot) { router in
                        router.view
                            .transition(.slide)
                            .uipNavigationBarHidden(true)
                            .ignoresSafeArea()
                            .environmentObject(tabBarSelection)
                    }
                ).tabItem {
                    // image
                }
                .tag(tabs[1].tag)
                .ignoresSafeArea()
                
                AnyView(
                    UIPilotHost(addRequestPilot) { router in
                        router.view
                            .transition(.slide)
                            .uipNavigationBarHidden(true)
                            .ignoresSafeArea()
                            .environmentObject(tabBarSelection)
                    }
                ).tabItem {
                    // image
                }
                .tag(tabs[2].tag)
                .ignoresSafeArea()
                
                AnyView(
                    UIPilotHost(favoritePilot) { router in
                        router.view
                            .transition(.slide)
                            .uipNavigationBarHidden(true)
                            .ignoresSafeArea()
                            .environmentObject(tabBarSelection)
                    }
                ).tabItem {
                    // image
                }
                .tag(tabs[3].tag)
                .ignoresSafeArea()
                
                AnyView(
                    UIPilotHost(morePilot) { router in
                        router.view
                            .transition(.slide)
                            .uipNavigationBarHidden(true)
                            .ignoresSafeArea()
                            .environmentObject(tabBarSelection)
                    }
                ).tabItem {
                    // image
                }
                .tag(tabs[4].tag)
                .ignoresSafeArea()
            }
            .environmentObject(popupPresent)
             
            if #available(iOS 15.0, *) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [
                        .white,
                        .white,
                    ]),
                                   startPoint: .leading,
                                   endPoint: .bottom)
                    .frame(height: 100,
                           alignment: .bottom)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(30)
                    .shadow(radius: 5)
                    .padding(.top, -30)
                    .overlay {
                        HStack {
                            ForEach(tabs) { tap in
                                TabBarItemView(selectedTab: $tabBarSelection.selectedTab, item: tap)
                                    .environmentObject(mainPilot)
                                    .environmentObject(servicesPilot)
                                    .environmentObject(addRequestPilot)
                                    .environmentObject(favoritePilot)
                                    .environmentObject(morePilot)
                                    .environmentObject(popupPresent)
                            }
                        }
                        .background(Color.clear)
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 40)
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        .ignoresSafeArea()
        .background(Color.white.opacity(0.3))
        .popup(isPresented: popupPresent.isSheetPresented, alignment: .bottom) {
            popupPresent.popupView
        }
        .popup(isPresented: popupPresent.isPopupPresented) {
            popupPresent.popupView
        }
    }
}

#Preview {
    HomeScreen()
}


struct TabBarItemView: View {
    @EnvironmentObject var languageSettings: LanguageSettings
    
    @EnvironmentObject var mainPilot : UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot : UIPilot<ServicesDestination>
    @EnvironmentObject var addRequestPilot : UIPilot<AddRequestDestination>
    @EnvironmentObject var favoritePilot : UIPilot<FavoritesDestination>
    @EnvironmentObject var myAccountPilot : UIPilot<MyAccountDestination>
    @EnvironmentObject var popupPresent: PopupPresent
    @Binding var selectedTab: TabBarItemType

    var item: TabBarItem

    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                if selectedTab == item.tag {
                    switch $selectedTab.wrappedValue {
                    case TabBarItemType.TabBarMain:
                        mainPilot.popTo(.main)
                    case TabBarItemType.TabBarService:
                        servicesPilot.popTo(.services)
                    case TabBarItemType.TabBarAddRequest:
                        addRequestPilot.popTo(.addRequest)
                    case TabBarItemType.TabBarMessage:
                        favoritePilot.popTo(.favorites)
                    case TabBarItemType.TabBarMyAccount:
                        myAccountPilot.popTo(.myAccount)
                    }
                } else {
                    self.selectedTab = item.tag
                }
            }
        }){
            VStack(spacing: 0) {
                Image(item.icon)
                    .renderingMode(.template)
                    .foregroundColor(getSelectedColor(tag: item.tag))
                    .frame(width: 30, height: 30)
                    .imageScale(.large)
                    .padding(5)
                
                
                TabBarText(text: item.tag.localized())
//                    .font(.system(size: 12))
//                    .fontWeight(.heavy)
                    .foregroundColor(getSelectedColor(tag: item.tag))
            }
            
        }
        .frame(maxWidth: .infinity)
        .navigationBarHidden(true)
    }
    
    func getSelectedColor(tag: TabBarItemType) -> Color {
        self.selectedTab != tag ?  R.color.colorBBC1CE.name.getColor() : R.color.colorPrimary.name.getColor()
    }
}

enum TabBarItemType: String {
    case TabBarMain
    case TabBarService
    case TabBarAddRequest
    case TabBarMessage
    case TabBarMyAccount
    
    func localized() -> LocalizedStringKey {
        switch self {
        case .TabBarMain:
            return R.string.localizable.main.localized
        case .TabBarService:
            return R.string.localizable.services.localized
        case .TabBarAddRequest:
            return R.string.localizable.add.localized
        case .TabBarMessage:
            return R.string.localizable.favorites.localized
        case .TabBarMyAccount:
            return R.string.localizable.myAccount.localized
        }
    }
}

class TabBarSelection: ObservableObject {
    @Published var selectedTab: TabBarItemType = TabBarItemType.TabBarMain
}

struct TabBarItem: Identifiable {
    var id = UUID()
    var tag: TabBarItemType
    var icon: String
}
