//
//  Pokemon.swift
//  SwappPokeDex
//
//  Created by Colton Swapp on 8/4/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation
struct Pokemon: Decodable {
    
    let name: String
    let id: Int
    let sprites: Sprites
    let types: [Slot]
    
    struct Slot: Decodable {
        let pokemonType: PokeType
        
        struct PokeType: Decodable {
            let type: String
        }
    }
    
    struct Sprites: Decodable {
        
        let classic: URL
        
        //CodingKeys allows us to use our own naming conventions
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
        }//End of enum
        
    }//End of struct
    
}//End of struct
