//
//  ContentView.swift
//  JPApexPredators17
//
//  Created by Artem Golovchenko on 2024-08-17.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    var predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    
    @State var selection = PredatorType.all
    
    private let userDefaults = UserDefaults.standard
    
    var filteredDinos: [ApexPredator] {
        return predators.filterAndSort(alphabetical: alphabetical, type: selection, searchTerm: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)), predator: predator)
                } label: {
                    HStack {
                        //image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            //name
                            Text(predator.name)
                                .fontWeight(.bold)
                                
                            //type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 13)
                                .background(Color(predator.type.background))
                                .clipShape(.rect(cornerRadius: 15))
                                
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            predators.deletePredator(predator)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }

                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation {
                            alphabetical.toggle()
                            userDefaults.set(alphabetical, forKey: "Sorting")
                        }
                    }, label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $selection.animation()) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            })
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
        }
        .preferredColorScheme(.dark)
        .onChange(of: selection) {
            userDefaults.set(selection.rawValue, forKey: "Type")
        }
        .onAppear {
            alphabetical = retrieveSortingData("Sorting") ?? false
            selection = retrieveTypeData("Type") ?? .all
        }
    }
    
    func retrieveSortingData(_ key: String) -> Bool? {
        let result = userDefaults.bool(forKey: "Sorting")
        return result
    }
    
    func retrieveTypeData(_ key: String) -> PredatorType? {
        let rawValue = userDefaults.string(forKey: "Type")
        let result = PredatorType(rawValue: rawValue ?? "all")
        return result
    }
    
}

#Preview {
    ContentView()
}
