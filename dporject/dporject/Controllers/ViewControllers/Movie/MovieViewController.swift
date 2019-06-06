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
    @IBOutlet weak var cinemaMapView: MKMapView!
    @IBOutlet weak var cinemaLabel: UILabel!
    var actionButton: ActionButton!

    private let networkFacade = NetworkServiceFacade()
    
    fileprivate var modifiedListOfComments = [Comment](){
        didSet{
            DispatchQueue.main.async {
                self.commentCollectionView.reloadData()
                self.commentTitleLabel.text = "Comments (\(self.modifiedListOfComments.count))"
                self.commentCollectionView.scrollToFirst()
            }
            
        }
    }
    
    fileprivate var listOfRating = [Rating](){
        didSet{
            DispatchQueue.main.async {
                self.ratingLabel.setRatingStars(ratingList: self.listOfRating)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let movie = selectedMovie else{
            fatalError("Could not load movie")
        }
        networkFacade.removeObserveComments(path: "\(Paths.COMMENTS)/\(movie.id!)")
        networkFacade.removeObserveRating(path: "\(Paths.RATING)/\(movie.id!)")
    }
    
    private func initialize(){
        setUpDelegate()
        setUpComponents()
    }
    
    private func setUpDelegate(){
        guard let movie = selectedMovie else{
            fatalError("Could not load movie")
        }
        
        
        
        networkFacade.delegate = self
        networkFacade.observeComments(path: "\(Paths.COMMENTS)/\(movie.id!)")
        networkFacade.observeRatings(path: "\(Paths.RATING)/\(movie.id!)")
        if movie.cinemas != nil {
            networkFacade.getListOfCinemas(path: Paths.CINEMAS)
        }
        //Comment Collection View
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
    }
    
    private func setUpComponents(){
         setUpFloatingButtons()
        
         movieImageView.roundedCorner(corners: [.bottomLeft, .bottomRight], radius: 40)
       
        guard let movie = selectedMovie else{
            fatalError("Could not load movie")
        }
        
        movieImageView.load(urlString: movie.image!)
        movieNameLabel.text = movie.name
        genreLabel.text = movie.genre
        ratingLabel.text = "N/A - Be the first one to vote"
        descriptionLabel.text = movie.description
        cinemaLabel.text = "Cinema (None)"
        
    }

    /// Set up Floating Button
    private func setUpFloatingButtons(){
        //Comment Button
        let addComment = ActionButtonItem(title: "Comment", image: Icons.ADD_COMMENT)
        addComment.action = { item in
            self.actionButton.toggleMenu()
            self.performSegue(withIdentifier: Identifiers.MOVIE_TO_COMMENTMODAL, sender: nil)
            
        }
        
        //Rating Button
        let ratingButton = ActionButtonItem(title: "Rate", image: Icons.RATE)
        ratingButton.action = {item in
            self.actionButton.toggleMenu()
            self.performSegue(withIdentifier: Identifiers.MOVIE_TO_RATINGMODAL, sender: nil)
        }
        
        //Favourite Button
        let favouriteButton = ActionButtonItem(title: "Favourite", image: Icons.FAVOURITE)
        favouriteButton.action = {item in
            self.actionButton.toggleMenu()
            self.performSegue(withIdentifier: Identifiers.MOVIE_TO_ALERTMODAL, sender: nil)
        }
        
        //Sharing Button
        let sharingButton = ActionButtonItem(title: "Share", image: Icons.SHARE)
        sharingButton.action = {item in
            self.actionButton.toggleMenu()
            self.performSegue(withIdentifier: Identifiers.MOVIE_TO_ALERTMODAL, sender: nil)
        }
        
        //Sharing Button
        let reportButton = ActionButtonItem(title: "Report", image: Icons.REPORT)
        reportButton.action = {item in
            self.actionButton.toggleMenu()
            self.performSegue(withIdentifier: Identifiers.MOVIE_TO_ALERTMODAL, sender: nil)
        }
        
        //Action Button
        actionButton = ActionButton(attachedToView: self.view, items: [addComment, favouriteButton, reportButton, sharingButton,  ratingButton])
        actionButton.action = {button in button.toggleMenu()}
        actionButton.backgroundColor = CustomColors.MAIN
        actionButton.backgroundColorSelected = CustomColors.MAIN_DISABLED
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let movie = selectedMovie else {
            fatalError("MovieViewController: cannot load movie" )
        }
        // Get the new view controller using segue.destination.
        if let commentViewController = segue.destination as? CommentModalViewController{
            commentViewController.selectedMovie = movie
        }
        else if let ratingViewController = segue.destination as? RatingModalViewController{
            ratingViewController.selectedMovie = movie
        }
        else if let alertModalController = segue.destination as? AlertViewController{
            alertModalController.bind(alertType: .INFO, content: AlertMessages.INFO_NOT_IMPLEMENTED)
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
/*
extension MovieViewController: DatabaseNetworkControllerDelegate{
    func watchListOfComments(comments: [Comment]) {
        self.originalListOfComment = comments
    }
    
    func watchListOfRatings(ratings: [Rating]) {
        self.listOfRating = ratings
    }
    
    
    func didReceivedListOfCinemas(cinemas: [Cinema]) {
        self.listOfCinemas = cinemas
    }
}
*/
extension MovieViewController: NetworkServiceFacadeDelegate{
    func watchListOfComments(comments: [Comment]) {
        self.originalListOfComment = comments
    }
    
    func watchListOfRatings(ratings: [Rating]) {
        self.listOfRating = ratings
    }
    
    func didReceivedListOfCinemas(cinemas: [Cinema]) {
        self.listOfCinemas = cinemas
    }
}
