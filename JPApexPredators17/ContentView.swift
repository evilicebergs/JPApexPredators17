//
//  ContentView.swift
//  JPApexPredators17
//
//  Created by Artem Golovchenko on 2024-08-17.
//

import SwiftUI

struct ContentView: View {
    
    var predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    
    @State var selection = PredatorType.all
    
    var filteredDinos: [ApexPredator] {
        return predators.filterAndSort(alphabetical: alphabetical, type: selection, searchTerm: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator)
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
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation {
                            alphabetical.toggle()
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
    }
}

#Preview {
    ContentView()
}
