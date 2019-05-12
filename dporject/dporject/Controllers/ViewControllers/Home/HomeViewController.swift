//
//  HomeViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 24/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    private let databaseNetworkController = DatabaseNetworkController()
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var listOfMovies = [Movie](){
        didSet{
            //self.collectionView.reloadSections(IndexSet(integer: 0))
            self.collectionView.reloadData()
        }
    }
    
    fileprivate var selectedMovie: Movie!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.a
        
        databaseNetworkController.delegate = self
        databaseNetworkController.getListOfObjectsFrom(path: "popular",  withDataType: "Movie")
        
    }
    
    @IBAction func testButton(_ sender: Any) {
        databaseNetworkController.getListOfObjectsFrom(path: "popular", withDataType: "Movie")
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let movieViewController = segue.destination as? MovieViewController{
            //Pass the movie to movie view controller
            movieViewController.movie = selectedMovie
        }
    }
    

}

//Create extesnsion to conform Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hotMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotMoviesCell", for: indexPath) as! HotMoviesCollectionViewCell
        
        let hotMovie = listOfMovies[indexPath.row]
        
        hotMovieCell.bind(movie: hotMovie)
        
        return hotMovieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovie = listOfMovies[indexPath.row]
        performSegue(withIdentifier: "homeToMovie", sender: nil)
    }
}

//Create extension to conform Delegate
extension HomeViewController: DatabaseNetworkControllerDelegate{
    func didReceivedListOfMovies(movies: [Movie]) {
        self.listOfMovies = movies
    }
}
