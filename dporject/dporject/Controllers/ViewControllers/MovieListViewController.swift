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
    
    fileprivate var listOfMovie = [Movie](){
        didSet{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = genre
     
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    
}
