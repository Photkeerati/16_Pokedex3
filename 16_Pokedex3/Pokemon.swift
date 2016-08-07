//
//  Pokemon.swift
//  16_Pokedex3
//
//  Created by Photkeerati on 8/7/2559 BE.
//  Copyright © 2559 Photkeerati. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name:String!
    private var _pokedexId:Int!
    
    var name : String {
        return _name
    }
    
    var pokedexId:Int {
        return _pokedexId
    }
    
    init(name:String , pokedexId:Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
    
}
