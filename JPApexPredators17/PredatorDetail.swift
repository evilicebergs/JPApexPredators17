//
//  PredatorDetail.swift
//  JPApexPredators17
//
//  Created by Artem Golovchenko on 2024-08-25.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    
    @State var position: MapCameraPosition
    
    var predator: ApexPredator
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.background)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .black, location: 1) ], startPoint: .top, endPoint: .bottom)
                        }
                    NavigationLink {
                        PredatorImage(predator: predator)
                    } label: {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                            .scaleEffect(x: -1)
                            .shadow(color: .black, radius: 7)
                            .offset(y: 20)
                    }
                }
                VStack(alignment: .leading) {
                    //predator Name
                    Text(predator.name)
                        .font(.largeTitle)
                        
                    //map
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80)))
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                    }
                    .frame(height: 125)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "greaterthan")
                            .imageScale(.large)
                            .font(.title3)
                            .padding(.trailing, 5)
                    }
                    .overlay(alignment: .topLeading) {
                        Text("Current Location")
                            .padding([.leading, .bottom], 5)
                            .padding(.trailing, 8)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(bottomTrailingRadius: 16))
                    }
                    .clipShape(.rect(cornerRadius: 15))
                    
                    //movie list
                    Text("Appears in:")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                            Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    //movie list
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top, 15)
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    
                    //link
                    Text("Read More: ")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom, 15)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack {
        PredatorDetail(position: .camera(MapCamera(centerCoordinate: Predators().allApexPredators[2].location, distance: 30000)), predator: Predators().allApexPredators[2])
            .preferredColorScheme(.dark)
    }
}
