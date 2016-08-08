//
//  ViewController.swift
//  16_Pokedex3
//
//  Created by Photkeerati on 8/7/2559 BE.
//  Copyright © 2559 Photkeerati. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UISearchBarDelegate  {

    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var collectionView:UICollectionView!
    var pokemon = [Pokemon]()
    var filterPokemon = [Pokemon]()
    var inSearchMode : Bool = false
    var musicPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        initAudio()
        
        parsePokemonCSV()
        searchBar.delegate = self
        
    }

  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func initAudio() {
        do {
            let url = Bundle.main.url(forResource: "music", withExtension: "mp3")!
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0.25
//            musicPlayer.play()
        } catch {
            
        }
        
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
           let csv = try CSV.init(contentsOfURL: path!)
            let rows = csv.rows
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                pokemon.append(Pokemon(name: name, pokedexId: pokeID))
            }
            
        } catch {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filterPokemon.count
        }
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            if inSearchMode {
            cell.configureCell(pokemon: filterPokemon[indexPath.row])
            } else {
            cell.configureCell(pokemon: pokemon[indexPath.row])
            }
            
            return cell
        }
        
         return UICollectionViewCell()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 100)
    }
    
    @IBAction func musicButtonPress(sender:AnyObject){
        if musicPlayer.isPlaying {
            musicPlayer.stop()
        } else {
            musicPlayer.play()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text  == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
        } else {
            inSearchMode = true
            
            let lower = searchBar.text?.lowercased()
            filterPokemon = pokemon.filter({$0.name.range(of:lower!) != nil})
            collectionView.reloadData()
        }
        
        
    }


}

