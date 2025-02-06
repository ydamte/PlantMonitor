//
//  PlantDetailView.swift
//  plantMonitor
//
//  Created by Yeabsera Damte on 11/22/24.
//

import SwiftUI

struct PlantDetailView: View {
    @ObservedObject var plant: Plant
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ZStack {
            // Background Image
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Content Overlaid on Background
            Form {
                Section(header: Text("Plant Details").foregroundColor(.black)) {
                    TextField("Name", text: nameBinding)
                        .foregroundColor(.black)
                    Stepper("Watering Frequency: \(plant.wateringFrequency) days",
                            value: $plant.wateringFrequency,
                            in: 1...30)
                        .foregroundColor(.black)
                    DatePicker("Last Watered", selection: lastWateredBinding,
                               displayedComponents: .date)
                        .foregroundColor(.black)
                }
            }
            .background(Color.clear)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(plant.name ?? "Plant Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    try? viewContext.save()
                }
                .foregroundColor(.black)
            }
        }
        .onAppear {
            // Hide the tab bar
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let tabBarController = windowScene.windows.first?.rootViewController as? UITabBarController {
                tabBarController.tabBar.isHidden = true
            }
            // Adjust navigation bar appearance
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().tintColor = .black
        }
        .onDisappear {
            // Show the tab bar again
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let tabBarController = windowScene.windows.first?.rootViewController as? UITabBarController {
                tabBarController.tabBar.isHidden = false
            }
            // Restore the default appearance when leaving the view
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().tintColor = .white
        }
    }

    // Computed binding for plant.name
    private var nameBinding: Binding<String> {
        Binding<String>(
            get: { plant.name ?? "" },
            set: { plant.name = $0 }
        )
    }

    // Computed binding for plant.lastWatered
    private var lastWateredBinding: Binding<Date> {
        Binding<Date>(
            get: { plant.lastWatered ?? Date() },
            set: { plant.lastWatered = $0 }
        )
    }
}
