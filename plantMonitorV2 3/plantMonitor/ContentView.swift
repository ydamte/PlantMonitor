//
//  ContentView.swift
//  plantMonitor
//
//  Created by Yeabsera Damte on 11/21/24.
//

//Programmer: Yeabsera Damte
//Date: 11/22/2024
//Xcode (Version 16.0)
//macOS Sequoia 16.1
//Description: This app is an interactive application, that allows the user to add plants that are in their garden.
//The user can add information like the name of the plant, the last date it was watered, and the frequency of watering it needs.
//In addition, they can search for basic information about various garden plants including fruits and vegetables such as tomatoes and strawberries in the discover tab.
//References: ChatGPT for debugging and modifying algorithm design and Xcode documentation for configurations

import SwiftUI
import CoreData

@main
struct plantMonitorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct MainView: View {
    init() {
        // TabBar Appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()

        // Set the background color of the tab bar (if needed)
        tabBarAppearance.backgroundColor = UIColor.clear

        // Set the tab bar item appearance
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20) // Increase font size as needed
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20)
        ]

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes

        // Set the tint color for the tab bar items (for the icons)
        UITabBar.appearance().tintColor = .white

        UITabBar.appearance().standardAppearance = tabBarAppearance

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        // NavigationBar Appearance (remains the same)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance

        // Set the tint color for navigation items
        UINavigationBar.appearance().tintColor = .white
    }

    var body: some View {
        TabView {
            MyPlantsView()
                .tabItem {
                    Label("My Plants", systemImage: "leaf")
                }

            DiscoverPlantsView()
                .tabItem {
                    Label("Discover Plants", systemImage: "magnifyingglass")
                }
        }
        .accentColor(.white) // Ensure the selected tab item is white
    }
}



extension View {
    func backgroundImage() -> some View {
        self
            .background(
                Image("BackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .offset(y: -20)
                    .ignoresSafeArea()
            )
    }
}




struct HideTabBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(HideTabBarHelper())
    }
}

struct HideTabBarHelper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            viewController.tabBarController?.tabBar.isHidden = true
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        DispatchQueue.main.async {
            uiViewController.tabBarController?.tabBar.isHidden = true
        }
    }
}

extension View {
    func hideTabBar() -> some View {
        self.modifier(HideTabBarModifier())
    }
}

