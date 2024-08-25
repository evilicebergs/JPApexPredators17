//
//  Predators.swift
//  JPApexPredators17
//
//  Created by Artem Golovchenko on 2024-08-24.
//

import Foundation

class Predators {
    
    var apexPredators: [ApexPredator] = []
    var allApexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error with handling JSON: \(error)")
            }
        }
    }
    
    func sort(by alphabetical: Bool, in predators: [ApexPredator]) -> [ApexPredator] {
        if alphabetical {
            return predators.sorted { return $0.name < $1.name }
        } else {
            return predators.sorted { return $0.id < $1.id }
        }
    }
    
    func filter(by type: PredatorType) -> [ApexPredator] {
        if type == .all {
            return allApexPredators
        } else {
            return allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
    
    func searchPredator(with searchTerm: String, in predators: [ApexPredator]) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return predators
        } else {
            return predators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func filterAndSort(alphabetical: Bool, type: PredatorType, searchTerm: String) -> [ApexPredator] {
        var filteredDinos = filter(by: type)
        
        filteredDinos = sort(by: alphabetical, in: filteredDinos)
        
        return searchPredator(with: searchTerm, in: filteredDinos)
    }
    
}
