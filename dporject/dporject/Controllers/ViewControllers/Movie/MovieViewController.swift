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
    
    var selectedMovie: Movie!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieImageView: CustomUIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var floattingAddButton: UIButton!
    @IBOutlet weak var cinemaMapView: MKMapView!
    @IBOutlet weak var cinemaLabel: UILabel!
    
    private var currentUser: User!
    private let userAuthenticationNetworkController = UserNetworkController()
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
    
    private var thisMoviesListOfCinemas = [Cinema](){
        didSet{
            self.cinemaMapView.addAnnotations(thisMoviesListOfCinemas)
            self.cinemaMapView.centerMapOnLocationWithCoordinate(regionRadius: 10000)
            self.cinemaLabel.text = "Cinema (\(self.thisMoviesListOfCinemas.count))"
        }
    }
    
    fileprivate var listOfCinemas = [Cinema](){
        didSet{
            guard let validCinemasMovie = self.selectedMovie.cinemas else {
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
        userAuthenticationNetworkController.delegate = self
        userAuthenticationNetworkController.authenticationListener()
        
        databaseNetworkController.delegate = self
        databaseNetworkController.observeDatabase(path: "comments/\(selectedMovie.id!)")
        
        if selectedMovie.cinemas != nil {
            databaseNetworkController.getListOfObjectsFrom(path: "cinemas", withDataType: "Cinema")
        }
        
        
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        
        

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let movie = selectedMovie else{
            fatalError("Could not load movie")
        }
        
        floattingAddButton.setBackgroundImage(Icons.ADD, for: .normal)
        
        movieImageView.load(urlString: movie.image!)
        movieNameLabel.text = movie.name
        yearLabel.text = movie.year
        ratingLabel.text = movie.rating
        descriptionLabel.text = movie.description
        cinemaLabel.text = "Cinema (None)"
        
        movieImageView.roundedCorner(corners: [.bottomLeft, .bottomRight], radius: 40)
        
    }
    
   

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseNetworkController.removeObserveDatabase(path: "comments/\(selectedMovie.id!)")
    }
    
    @IBAction func floattingAddButtonOnTapped(_ sender: Any) {
        performSegue(withIdentifier: "movieToComment", sender: nil)
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
    }
 

}

//Create extension to conform Collection View
extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if modifiedListOfComments.count == 0{
            self.commentCollectionView.setEmptyMessage("There are no comments!")
        }else{
            self.commentCollectionView.restore()
        }
        return modifiedListOfComments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let commentViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentListCollectionViewCell
        
        let comment = modifiedListOfComments[indexPath.row]
        
        commentViewCell.bind(comment: comment)
        
        return commentViewCell
    }
    
    
    
}


//Create extension to conform UserAuthenticationNetwork
extension MovieViewController: UserNetworkControllerDelegate{
    func didReceiveUser(user: User) {
        currentUser = user
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
