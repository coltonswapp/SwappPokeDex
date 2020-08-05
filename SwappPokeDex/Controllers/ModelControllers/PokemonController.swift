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
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return completion(.failure(.invalidURL))}
        let finalURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        } .resume()
        
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        //Step 1 - URL
        let url = pokemon.sprites.classic
        
        //Step 2 - Data Task
        URLSession.shared.dataTask(with: url) { data, _, error in
            //Step 3 - Handle Error
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            return completion(.success(image))
    
        }.resume()
    }
    
}
