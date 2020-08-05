//
//  PokemonViewController.swift
//  SwappPokeDex
//
//  Created by Colton Swapp on 8/4/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var wildPokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var aWildPokemonLabel: UILabel!
    @IBOutlet weak var pokemonNameMainLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel1: UILabel!
    @IBOutlet weak var pokemonTypeLabel2: UILabel!
    @IBOutlet weak var pokemonTypeLabel3: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonSearchBar.delegate = self
    }
    
    //MARK: - Private Methods
    private func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
        
        PokemonController.fetchSprite(for: pokemon) { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self?.pokemonSpriteImageView.image = sprite
                    self?.pokemonNameMainLabel.text = pokemon.name
                    self?.wildPokemonNameLabel.text = pokemon.name
                    self?.aWildPokemonLabel.text = "A wild \(pokemon.name) appeared!"
                    self?.pokemonIDLabel.text = "#\(pokemon.id)"
                    // self?.pokemonTypeLabel1.text
                    
                    
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }

}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        PokemonController.fetchPokemon(for: searchTerm) { [weak self] (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let pokemon):
                    self?.fetchSpriteAndUpdateViews(for: pokemon)
                    
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}//End of extension
