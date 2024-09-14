//
//  PredatorImage.swift
//  JPApexPredators17
//
//  Created by Artem Golovchenko on 2024-09-14.
//

import SwiftUI

struct PredatorImage: View {
    
    var predator: ApexPredator
    @State var direction = false
    
    var body: some View {
            ZStack {
                Image(predator.background)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(predator.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                    .shadow(color: .black, radius: 7)
                    .scaleEffect(x: direction ? 1 : -1)
                    
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    withAnimation {
                        direction.toggle()
                    }
                } label: {
                    Image(systemName: "lessthan")
                        .scaleEffect(x: direction ? -1 : 1)
                        .font(.largeTitle)
                        .imageScale(.large)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 15))
                        .shadow(radius: 7)
                        .padding()
                        
                }

            }
        }
}

#Preview {
    PredatorImage(predator: Predators().allApexPredators[10])
        .preferredColorScheme(.dark)
}
