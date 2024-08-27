//
//  ApexPredator.swift
//  JPApexPredators17
//
//  Created by Artem Golovchenko on 2024-08-24.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    
    var id: Int
    var name: String
    var type: PredatorType
    var latitude: Double
    var longitude: Double
    var movies: [String]
    var movieScenes: [MovieScenes]
    var link: String
    
    var image: String {
        return name
            .lowercased()
            .replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var background: String {
        return type.rawValue
    }
    
    struct MovieScenes: Decodable, Identifiable {
        var id: Int
        var movie: String
        var sceneDescription: String
        
    }
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    
    var id: PredatorType { self }
    
    case all
    case land
    case air
    case sea
    
    var background: Color {
        switch self {
        case .air:
            .teal
        case .land:
            .brown
        case .sea:
            .blue
        case .all:
            .black
        }
    }
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}


