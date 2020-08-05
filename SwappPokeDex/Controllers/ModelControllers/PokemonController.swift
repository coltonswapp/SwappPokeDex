//
//  PokemonController.swift
//  SwappPokeDex
//
//  Created by Colton Swapp on 8/4/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation
import class UIKit.UIImage

class PokemonController {
    
    static func fetchPokemon(for searchTerm: String, completion: @escaping (Result <Pokemon, PokemonError>) -> Void) {
        guard var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return completion(.failure(.invalidURL))}
        let finalURL = baseURL.appendPathComponent(searchTerm.lowercased())
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thro))
        }
        }
        
    }
    
}
