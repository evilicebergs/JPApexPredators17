//
//  PredatorMap.swift
//  JPApexPredators17
//
//  Created by Artem Golovchenko on 2024-09-14.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    
    @State var position: MapCameraPosition
    @State var satelite = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satelite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button(action: {
                satelite.toggle()
            }, label: {
                Image(systemName: satelite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(4)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 15))
                    .shadow(radius: 3)
                    .padding()
                
            })
        }
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().allApexPredators[2].location,
                                            distance: 1000,
                                            heading: 250,
                                            pitch: 80)))
    .preferredColorScheme(.dark)
}
