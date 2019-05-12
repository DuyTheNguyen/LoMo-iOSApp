//
//  GenreViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {

    private var listOfGenre = [Genre](){
        didSet{
            print(listOfGenre)
            self.genreCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    private let databaseNetworkController = DatabaseNetworkController()
    
    fileprivate var selectedGenre: Genre!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseNetworkController.delegate = self
        databaseNetworkController.getListOfObjectsFrom(path: "genre", withDataType: "Genre")
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let movieListViewController = segue.destination as? MovieListViewController{
            movieListViewController.genre = selectedGenre
        }
    }
 

}

//Create extension to conform Collection View
extension GenreViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let genreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionViewCell
        
        let genre = listOfGenre[indexPath.row]
        
        genreCell.bind(genre: genre)
        return genreCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGenre = listOfGenre[indexPath.row]
        performSegue(withIdentifier: "genreToMovieList", sender: nil)
    }
    
}

//Create extension to conform delegate
extension GenreViewController: DatabaseNetworkControllerDelegate{
    func didReceivedListOfGenres(genres: [Genre]) {
        self.listOfGenre = genres
    }
}

