//
//  MyPlantsView.swift
//  plantMonitor
//
//  Created by Yeabsera Damte on 11/22/24.
//

import SwiftUI


 struct MyPlantsView: View {
     @Environment(\.managedObjectContext) private var viewContext
     @FetchRequest(
         sortDescriptors: [NSSortDescriptor(keyPath: \Plant.name, ascending: true)],
         animation: .default)
     private var plants: FetchedResults<Plant>

     var body: some View {
         //Spacer().frame(height: 30)
         NavigationView {
             List {
                 ForEach(plants) { plant in
                     NavigationLink(destination: PlantDetailView(plant: plant)) {
                         Text(plant.name ?? "Unknown Plant")
                             .foregroundColor(.black) // Change text color to black
                     }
                 }
                 .onDelete(perform: deletePlants)
             }
             .listStyle(PlainListStyle())
             //.background(Color.clear)
             .background(Image("BackgroundImage"))
             .scrollContentBackground(.hidden)
             .padding(.horizontal, 20) // Add horizontal padding
             
             
             .navigationTitle("My Plants")
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button(action: addPlant) {
                         Image(systemName: "plus")
                     }
                 }
             }
         }
         .navigationViewStyle(StackNavigationViewStyle())
         //.background(Image("BackgroundImage"))
         .backgroundImage()
     }

     private func addPlant() {
         withAnimation {
             let newPlant = Plant(context: viewContext)
             newPlant.name = "New Plant"
             newPlant.wateringFrequency = 3
             newPlant.lastWatered = Date()

             do {
                 try viewContext.save()
             } catch {
                 let nsError = error as NSError
                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
         }
     }

     private func deletePlants(offsets: IndexSet) {
         withAnimation {
             offsets.map { plants[$0] }.forEach(viewContext.delete)

             do {
                 try viewContext.save()
             } catch {
                 let nsError = error as NSError
                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
         }
     }
 }
 

/*
struct MyPlantsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plant.name, ascending: true)],
        animation: .default)
    private var plants: FetchedResults<Plant>

    var body: some View {
        ZStack {
            // Background Image
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Content Overlaid on Background
            NavigationView {
                List {
                    ForEach(plants) { plant in
                        NavigationLink(destination: PlantDetailView(plant: plant)) {
                            Text(plant.name ?? "Unknown Plant")
                                .foregroundColor(.black) // Change text color to black
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(8)
                        }
                        .listRowBackground(Color.clear) // Make row background transparent
                    }
                    .onDelete(perform: deletePlants)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear) // Make List background transparent
                .scrollContentBackground(.hidden) // For iOS 16 and above
                .padding(.horizontal, 20) // Add horizontal padding
                .navigationTitle("My Plants")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: addPlant) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .background(Color.clear) // Make NavigationView background transparent
            .onAppear {
                // Adjust navigation bar appearance
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().tintColor = .white // Set the color of navigation items
            }
            .onDisappear {
                // Restore default navigation bar appearance if necessary
            }
        }
    }

    private func addPlant() {
        withAnimation {
            let newPlant = Plant(context: viewContext)
            newPlant.name = "New Plant"
            newPlant.wateringFrequency = 3
            newPlant.lastWatered = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deletePlants(offsets: IndexSet) {
        withAnimation {
            offsets.map { plants[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
*/
