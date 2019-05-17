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
    
    private let databaseNetworkController = DatabaseNetworkController()
    
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
        databaseNetworkController.delegate = self
        //get list of movies based on path
        databaseNetworkController.getListOfObjectsFrom(path: "genremovies/\(genre.name ?? "")", withDataType: "Movie")
     
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
            return searchMovies.count
        }else{
            return listOfMovie.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieListCollectionViewCell
        
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
        selectedMovie = listOfMovie[indexPath.row]
        performSegue(withIdentifier: "movieListToMovie", sender: nil)
    }
    
}


//Create extension to comform delegate

extension MovieListViewController: DatabaseNetworkControllerDelegate{
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
}
