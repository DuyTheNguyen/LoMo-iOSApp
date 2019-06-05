//
//  MovieListViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 12/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    var genre: Genre!
    
    var selectedMovie: Movie!
    
    var searchMovies = [Movie]()
    var isSearching = false
    
    private let networkFacade = NetworkFacade()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    fileprivate var listOfMovie = [Movie](){
        didSet{
            //Refresh collection view whenever listOfMovie has new value
            self.moviesCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        networkFacade.delegate = self
        //get list of movies based on path
        networkFacade.getListOfMovies(path: "\(Paths.GENRE_MOVIES_LIST)/\(genre.name ?? "")")
     
        // Do any additional setup after loading the view.
    }
    
    func setUpNavBar(){
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = genre.name
        //let searchController = UISearchController(searchResultsController: nil)
        //navigationItem.searchController = searchController
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let movieViewController = segue.destination as? MovieViewController{
            movieViewController.selectedMovie = selectedMovie
        }
    }
    

}

//Create extension to conform Collection View
extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching{
            self.moviesCollectionView.restore()
            if searchMovies.count == 0{
                self.moviesCollectionView.setEmptyMessage(GeneralMessages.EMPTY_LIST_OF_RESULT_MOVIES)
            }
            return searchMovies.count
        }else{
            return listOfMovie.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier:Identifiers.MOVIE_CELL, for: indexPath) as! MovieListCollectionViewCell
        
        let movie: Movie!
        if isSearching{
            movie = searchMovies[indexPath.row]
        } else{
            movie = listOfMovie[indexPath.row]
            
        }
        movieCell.bind(movie: movie)
        return movieCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSearching{
            selectedMovie = searchMovies[indexPath.row]
        }else{
            selectedMovie = listOfMovie[indexPath.row]
        }
        performSegue(withIdentifier: Identifiers.MOVIELIST_TO_MOVIE, sender: nil)
    }
    
}


//Create extension to comform delegate

extension MovieListViewController: NetworkFacadeDelegate{
    func didReceivedListOfMovies(movies: [Movie]) {
        self.listOfMovie = movies
    }
    
}

extension MovieListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovies = listOfMovie.filter({ $0.name!.prefix(searchText.count) == searchText })
        isSearching = true
        self.moviesCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
