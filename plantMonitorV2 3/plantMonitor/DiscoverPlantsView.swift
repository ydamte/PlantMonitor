//
//  DiscoverPlantsView.swift
//  plantMonitor
//
//  Created by Yeabsera Damte on 11/22/24.
//

//EDIT
import SwiftUI

struct DiscoverPlantsView: View {
    // ... your existing properties ...
    @State private var searchQuery: String = ""
    @State private var plantInfo: String? = nil
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            VStack {
                // ... your existing content ...
                HStack {
                    TextField("Search for a plant...", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .foregroundColor(.black) // Adjust text color

                    Button(action: fetchPlantInfo) {
                        Image(systemName: "magnifyingglass")
                            .padding()
                    }
                }
                .padding()
                
                // Loading indicator
                if isLoading {
                    ProgressView("Loading...")
                        .padding()
                }
                
                // Display plant information
                if let plantInfo = plantInfo {
                    ScrollView {
                        Text(plantInfo)
                            .bold()
                            .padding()
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white) // Adjust text color
                    }
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer()
            }
            //.background(Color.clear)
            //.background(Color.green.opacity(0.3))
            .background(Image("BackgroundImage"))
            //.scaledToFill()
            //.ignoresSafeArea()
            .navigationTitle("Discover Plants")
        }
        .background(Color.clear)
        .backgroundImage()
    }
    
    /*
    private func fetchPlantInfo() {
        guard !searchQuery.isEmpty else {
            errorMessage = "Please enter a plant name."
            plantInfo = nil
            return
        }

        isLoading = true
        errorMessage = nil

        PlantService().fetchPlantInfo(for: searchQuery) { result in
            DispatchQueue.main.async {
                isLoading = false

                switch result {
                case .success(let info):
                    plantInfo = info
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    */
    private func fetchPlantInfo() {
        guard !searchQuery.isEmpty else {
            errorMessage = "Please enter a plant name."
            plantInfo = nil
            return
        }

        isLoading = true
        errorMessage = nil

        PlantService().fetchPlantInfo(for: searchQuery) { result in
            DispatchQueue.main.async {
                isLoading = false

                switch result {
                case .success(let info):
                    plantInfo = info
                    errorMessage = nil // Clear any previous error
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    plantInfo = nil // Clear any previous plant info
                }
            }
        }
    }

}

