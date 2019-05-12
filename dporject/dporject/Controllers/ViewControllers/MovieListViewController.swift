//
//  MovieListViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 12/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    var genre: String!
    
    var selectedMovie: Movie!
    
    private let databaseNetworkController = DatabaseNetworkController()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    fileprivate var listOfMovie = [Movie](){
        didSet{
            //Refresh collection view whenever listOfMovie has new value
            self.moviesCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = genre
    
        databaseNetworkController.delegate = self
        //get list of movies based on path
        databaseNetworkController.getListOfMoviesFrom(path: "genre/\(genre ?? "")")
     
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let movieViewController = segue.destination as? MovieViewController{
            movieViewController.movie = selectedMovie
        }
    }
    

}

//Create extension to conform Collection View
extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieListCollectionViewCell
        
        let movie = listOfMovie[indexPath.row]
        
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
    func didReceivedDictionaryOfMovies(movies: [Movie]) {
        self.listOfMovie = movies
    }
    
}


