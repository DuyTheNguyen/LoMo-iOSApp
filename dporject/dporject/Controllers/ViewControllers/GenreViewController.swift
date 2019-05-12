//
//  GenreViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {

    private let listOfGenre: [String] = ["Action", "Comedy", "Romance", "Sci-fi"]
    
    fileprivate var selectedGenre: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        genreCell.bind(name: genre)
        return genreCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGenre = listOfGenre[indexPath.row]
        performSegue(withIdentifier: "genreToMovieList", sender: nil)
    }
    
}

