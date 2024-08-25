//
//  PredatorDetail.swift
//  JPApexPredators17
//
//  Created by Artem Golovchenko on 2024-08-25.
//

import SwiftUI

struct PredatorDetail: View {
    
    var predator: ApexPredator
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .trailing) {
                    Image(predator.background)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .black, location: 1) ], startPoint: .top, endPoint: .bottom)
                        }
                
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                VStack(alignment: .leading) {
                    //predator Name
                    Text(predator.name)
                        .font(.largeTitle)
                        
                    
                    //map
                    
                    //movie list
                    Text("Appears in:")
                        .font(.title3)
                    
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
    }
}

#Preview {
    PredatorDetail(predator: Predators().allApexPredators[10])
        .preferredColorScheme(.dark)
}
