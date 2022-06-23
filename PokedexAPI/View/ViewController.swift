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
    //private var pokemonListViewModel: PokemonListViewModel!
    let pokePageViewModel = PokePageViewModel()
    //let parser = Webservice()
    //var pokemon = [PokeResult]()
    //var page = 0
    
    //var isPageRefreshing:Bool = false
    
    //var total_page = 5
    //var current_page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pokePageViewModel.fetchData(page: pokePageViewModel.page, cv: pokeCollectionView)
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
        
        
        //fetchData(page: current_page)
        
        /*parser.parsePoke { data in
            
            self.pokemon = data
            self.pokemonListViewModel = PokemonListViewModel(pokeList: data)
            DispatchQueue.main.async {
                self.pokeCollectionView.reloadData()
            }
        }*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as! Int
                
        let destVC = segue.destination as! DetailViewController
        let destC = pokePageViewModel.pokemonSelectIndex(indeks)
                
        destVC.result = destC.pokemon
    }
}

extension ViewController: UICollectionViewDelegate {
    /*func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(self.pokeCollectionView.contentOffset.y >= (self.pokeCollectionView.contentSize.height - self.pokeCollectionView.bounds.size.height)) {
            pokePageViewModel.page += 20
            if pokePageViewModel.page < 864 {
                print(pokePageViewModel.page)
                pokePageViewModel.fetchData(page: pokePageViewModel.page, cv: self.pokeCollectionView)
            }
        }
    }*/
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if(self.pokeCollectionView.contentOffset.y >= (self.pokeCollectionView.contentSize.height - self.pokeCollectionView.bounds.size.height)) {
            pokePageViewModel.page += 20
            if pokePageViewModel.page < 401 {
                print(pokePageViewModel.page)
                pokePageViewModel.fetchData(page: pokePageViewModel.page, cv: self.pokeCollectionView)
            }
        }
        
        /*if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            pokePageViewModel.page += 48
            if pokePageViewModel.page < 864 {
                pokePageViewModel.fetchData(page: pokePageViewModel.page, cv: self.pokeCollectionView)
            }
        }*/
        
        /*let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = abs(diffHeight - frameHeight);
        print("pullHeight:\(pullHeight)");
        if pullHeight >= 0 {
            pokePageViewModel.page += 1
            if pokePageViewModel.page < 200 {
                pokePageViewModel.fetchData(page: pokePageViewModel.page)
            }
        }*/
        
        /*if(self.pokeCollectionView.contentOffset.y >= (self.pokeCollectionView.contentSize.height - self.pokeCollectionView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pokePageViewModel.page += 20
                if pokePageViewModel.page < 400 {
                    pokePageViewModel.fetchData(page: pokePageViewModel.page)
                    isPageRefreshing = false
                }
            }
        }*/
        
        /*if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            pokePageViewModel.page += 20
            if pokePageViewModel.page < 360 {
            pokePageViewModel.fetchData(page: pokePageViewModel.page)
            }
        }*/
        
        /*pokePageViewModel.page += 48
        if pokePageViewModel.page < 864 {
            pokePageViewModel.fetchData(page: pokePageViewModel.page)
        }*/
        
        /*if pokePageViewModel.pokemons.count % 20 == 0 {
            pokePageViewModel.page += 20
            pokePageViewModel.fetchData(page: pokePageViewModel.page)
        }*/
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.item)
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    /*func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return pokemon.count
        return pokePageViewModel.pokemons.count
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
        
        /*let pokemonViewModel = self.pokemonListViewModel.pokemonAtIndex(indexPath.row)
        cell.pokeName.text = pokemonViewModel.name
        cell.pokeImg.load(urlString: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(indexPath.row + 1).png")*/
        cell.configure(with: pokePageViewModel.pokemons[indexPath.row], cellID: indexPath.row + 1)
        
        return cell
    }
    
    /*func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = abs(diffHeight - frameHeight);
        print("pullHeight:\(pullHeight)");
        if pullHeight == 0 {
            pokePageViewModel.page += 20
            if pokePageViewModel.page < 200 {
                pokePageViewModel.fetchData(page: pokePageViewModel.page)
            }
        }
    }*/
    
    /*func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /*if(self.pokeCollectionView.contentOffset.y >= (self.pokeCollectionView.contentSize.height - self.pokeCollectionView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pokePageViewModel.page += 1
                pokePageViewModel.fetchData(page: pokePageViewModel.page)
            }
        }*/
        
        /*if(self.pokeCollectionView.contentOffset.y >= (self.pokeCollectionView.contentSize.height - self.pokeCollectionView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pokePageViewModel.page += 20
                if pokePageViewModel.page < 400 {
                pokePageViewModel.fetchData(page: pokePageViewModel.page)
                }
            }
        }*/
     
     
    }*/
    

    
    /*func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(self.pokeCollectionView.contentOffset.y >= (self.pokeCollectionView.contentSize.height - self.pokeCollectionView.bounds.size.height)) {
            pokePageViewModel.page += 48
            if pokePageViewModel.page < 864 {
                print(pokePageViewModel.page)
                pokePageViewModel.fetchData(page: pokePageViewModel.page, cv: self.pokeCollectionView)
            }
        }
        
        /*if indexPath.row == pokePageViewModel.pokemons.count - 1 {
            pokePageViewModel.page += 1
            pokePageViewModel.fetchData(page: pokePageViewModel.page)
        }*/
        
        /*if current_page < total_page && indexPath.row == pokemon.count - 1 {
            current_page = current_page + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 10){
                self.fetchData(page: self.current_page)
            }
        }*/
    }*/
    
    /*private func fetchData(page: Int/*, comp: @escaping([PokeResult]) -> ()*/) {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(page)") else { return }
        
        
        //var request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                
            if error != nil {
                print(error.debugDescription)
                return
            } else if data != nil {
                var result: PokemonModel?
                do {
                    result = try JSONDecoder().decode(PokemonModel.self, from: data!)
                } catch {
                    
                }
                
                guard let finalResult = result else { return }
                let newPoke = finalResult.results
                self.pokemon.append(contentsOf: newPoke)
                //comp(self.pokemon)
                DispatchQueue.main.async {
                    self.pokeCollectionView.reloadData()
                }
            }
        }.resume()
    }*/
}
