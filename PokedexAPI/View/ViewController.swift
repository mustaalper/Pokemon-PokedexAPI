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
    let pokemonListViewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pokemonListViewModel.fetchData(page: pokemonListViewModel.page, cv: pokeCollectionView)
        pokeCollectionView.delegate = self
        pokeCollectionView.dataSource = self
        
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as! Int
                
        let destVC = segue.destination as! DetailViewController
        let destC = pokemonListViewModel.pokemonSelectIndex(indeks)
                
        destVC.result = destC.pokemon
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if(self.pokeCollectionView.contentOffset.y >= (self.pokeCollectionView.contentSize.height - self.pokeCollectionView.bounds.size.height)) {
            pokemonListViewModel.page += 20
            if pokemonListViewModel.page < 401 {
                print(pokemonListViewModel.page)
                pokemonListViewModel.fetchData(page: pokemonListViewModel.page, cv: self.pokeCollectionView)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.item)
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonListViewModel.pokemons.count
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
        
        cell.configCell(with: pokemonListViewModel.pokemons[indexPath.row], cellRow: indexPath.row + 1)
        
        return cell
    }
}
