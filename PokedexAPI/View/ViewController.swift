//
//  ViewController.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var pokeCollectionView: UICollectionView!
    let pokeCellId = "PokemonCollectionViewCell"
    private var pokemonListViewModel: PokemonListViewModel!
    let parser = Webservice()
    var pokemon = [PokeResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let desing: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                let width = self.pokeCollectionView.frame.size.width
                desing.sectionInset = UIEdgeInsets(top: 10, left: 2, bottom: 2, right: 2)
                desing.minimumInteritemSpacing = 5
                desing.minimumLineSpacing = 5
                let cellWidth = (width - 24) / 3
                desing.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.5)
                
        pokeCollectionView!.collectionViewLayout = desing
        
        let nibCell = UINib(nibName: pokeCellId, bundle: nil)
        pokeCollectionView.register(nibCell, forCellWithReuseIdentifier: pokeCellId)
        
        parser.parsePoke { data in
            
            self.pokemon = data
            self.pokemonListViewModel = PokemonListViewModel(pokeList: data)
            DispatchQueue.main.async {
                self.pokeCollectionView.reloadData()
            }
        }
        
        pokeCollectionView.delegate = self
        pokeCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as! Int
                
        let destVC = segue.destination as! DetailViewController
        let destC = pokemonListViewModel.pokemonSelectIndex(indeks)
                
        destVC.result = destC.pokemon
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - 36) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pokeCollectionView.dequeueReusableCell(withReuseIdentifier: pokeCellId, for: indexPath) as! PokemonCollectionViewCell
        
        let pokemonViewModel = self.pokemonListViewModel.pokemonAtIndex(indexPath.row)
        cell.pokeName.text = pokemonViewModel.name
        cell.pokeImg.load(urlString: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(indexPath.row + 1).png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let poke = self.pokemonListViewModel.pokemonSelectIndex(indexPath.row)
        //print("\(indexPath.row) - \(poke.name)")
        performSegue(withIdentifier: "toDetail", sender: indexPath.item)
        
    }

}
