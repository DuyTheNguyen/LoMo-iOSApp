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
            self.genreCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var allMovieLabel: UILabel!

    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    private let networkFacade = NetworkServiceFacade()
    
    fileprivate var selectedGenre: Genre!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the label can be tapped
        self.navigationController?.setNavbarTransparent()
        allMovieLabel.loadCustomLabel()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(allMoviesLabelOnTapped))
        allMovieLabel.isUserInteractionEnabled = true
        allMovieLabel.addGestureRecognizer(gesture)
        
        networkFacade.delegate = self
        networkFacade.getListOfGenre(path: Paths.GENRE)
        // Do any additional setup after loading the view.
    }
    
   
    
    @objc func allMoviesLabelOnTapped(){
        selectedGenre = Genre(name: "All", image: "")
        performSegue(withIdentifier: Identifiers.GENRE_TO_MOVIELIST, sender: nil)
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
        let genreCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.GENRE_CELL, for: indexPath) as! GenreCollectionViewCell
        
        let genre = listOfGenre[indexPath.row]
        
        genreCell.bind(genre: genre)
        return genreCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGenre = listOfGenre[indexPath.row]
        performSegue(withIdentifier: Identifiers.GENRE_TO_MOVIELIST, sender: nil)
    }
    
}

//Create extension to conform delegate
extension GenreViewController: NetworkServiceFacadeDelegate{
    func didReceivedListOfGenres(genres: [Genre]) {
        self.listOfGenre = genres
    }
}

