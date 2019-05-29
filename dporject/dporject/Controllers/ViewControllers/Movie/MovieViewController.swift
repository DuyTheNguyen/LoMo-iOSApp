//
//  MovieViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 12/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
import MapKit

class MovieViewController: UIViewController {
    
    var selectedMovie: Movie?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieImageView: CustomUIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var floattingAddButton: UIButton!
    @IBOutlet weak var cinemaMapView: MKMapView!
    @IBOutlet weak var cinemaLabel: UILabel!
    
    private let databaseNetworkController = DatabaseNetworkController()
    
    fileprivate var modifiedListOfComments = [Comment](){
        didSet{
            DispatchQueue.main.async {
                self.commentCollectionView.reloadData()
                self.commentTitleLabel.text = "Comments (\(self.modifiedListOfComments.count))"
                self.commentCollectionView.scrollToFirst()
            }
            
        }
    }
    
    fileprivate var originalListOfComment = [Comment](){
        didSet{
            modifiedListOfComments = originalListOfComment.sorted(by: { (c1, c2) -> Bool in
                c1.timestamp.fromTimeStampToDouble() > c2.timestamp.fromTimeStampToDouble()
            })
        }
    }
    
    fileprivate var thisMoviesListOfCinemas = [Cinema](){
        didSet{
            self.cinemaMapView.addAnnotations(thisMoviesListOfCinemas)
            self.cinemaMapView.centerMapOnLocationWithCoordinate(regionRadius: 10000)
            self.cinemaLabel.text = "Cinema (\(self.thisMoviesListOfCinemas.count))"
        }
    }
    
    fileprivate var listOfCinemas = [Cinema](){
        didSet{
            guard let movie = selectedMovie else{
                fatalError("Could not load movie")
            }
            guard let validCinemasMovie = movie.cinemas else {
                print("No cinema for this movie")
                return
            }

            thisMoviesListOfCinemas = listOfCinemas.filter { (cinema) -> Bool in
                 validCinemasMovie.contains(cinema.id)
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
        setUpComponents()
        registerInteraction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func initialize(){
        guard let movie = selectedMovie else{
            fatalError("Could not load movie")
        }
        
        //Database Network
        databaseNetworkController.delegate = self
        databaseNetworkController.observeDatabase(path: "\(Paths.COMMENTS)/\(movie.id!)")
        
        if movie.cinemas != nil {
            databaseNetworkController.getListOfObjectsFrom(path: Paths.CINEMAS, withDataType: .Cinema)
        }
        
        //Comment Collection View
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
    }
    
    private func setUpComponents(){
         floattingAddButton.setBackgroundImage(Icons.ADD, for: .normal)
         movieImageView.roundedCorner(corners: [.bottomLeft, .bottomRight], radius: 40)
        
        guard let movie = selectedMovie else{
            fatalError("Could not load movie")
        }
        
        movieImageView.load(urlString: movie.image!)
        movieNameLabel.text = movie.name
        genreLabel.text = movie.genre
        ratingLabel.setRatingStars(score: movie.rating!)
        descriptionLabel.text = movie.description
        cinemaLabel.text = "Cinema (None)"
        
    }
    
    private func registerInteraction(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ratingLabelOnTapped))
        ratingLabel.isUserInteractionEnabled = true
        ratingLabel.addGestureRecognizer(gesture)
    }
    
    @objc func ratingLabelOnTapped(){
        print("Tapped............")
        performSegue(withIdentifier: Identifiers.MOVIE_TO_RATINGMODAL, sender: nil)
    }
    
   
    
   

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let movie = selectedMovie else{
            fatalError("Could not load movie")
        }
        databaseNetworkController.removeObserveDatabase(path: "\(Paths.COMMENTS)/\(movie.id!)")
    }
    
    @IBAction func floattingAddButtonOnTapped(_ sender: Any) {
        performSegue(withIdentifier: Identifiers.MOVIE_TO_COMMENTMODAL, sender: nil)
    }
  
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if let commentViewController = segue.destination as? CommentModalViewController{
            guard let movie = selectedMovie else {
                fatalError("MovieViewController: cannot load movie" )
            }
            commentViewController.selectedMovie = movie
        }
        else if let ratingViewController = segue.destination as? RatingModalViewController{
            
        }
        
        
    }
 

}

//Create extension to conform Collection View
extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if modifiedListOfComments.count == 0{
            self.commentCollectionView.setEmptyMessage(GeneralMessages.EMPTY_LIST_OF_COMMENTS)
        }else{
            self.commentCollectionView.restore()
        }
        return modifiedListOfComments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let commentViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.COMMENT_CELL, for: indexPath) as! CommentListCollectionViewCell
        
        let comment = modifiedListOfComments[indexPath.row]
        
        commentViewCell.bind(comment: comment)
        
        return commentViewCell
    }
}

//Create extension to conform DatabaseNetworkController
extension MovieViewController: DatabaseNetworkControllerDelegate{
    func watchListOfComments(comments: [Comment]) {
        self.originalListOfComment = comments
    }
    
    func didReceivedListOfCinemas(cinemas: [Cinema]) {
        self.listOfCinemas = cinemas
    }
}
