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
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    
    private var currentUser: User!
    private let userAuthenticationNetworkController = UserAuthenticationNetworkController()
    private let databaseNetworkController = DatabaseNetworkController()
    fileprivate var listOfComments = [Comment](){
        didSet{
            DispatchQueue.main.async {
                self.commentCollectionView.reloadData()
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userAuthenticationNetworkController.delegate = self
        userAuthenticationNetworkController.authenticationListener()
        
        databaseNetworkController.delegate = self
        databaseNetworkController.observeDatabase(path: "comments/\(selectedMovie.id!)")
        
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        
        
        

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        guard let movie = selectedMovie else{
            fatalError("Could not load movie")
        }
        
        movieImageView.load(imageString: movie.image!)
        movieNameLabel.text = movie.name
        yearLabel.text = movie.year
        ratingLabel.text = movie.rating
        descriptionLabel.text = movie.description
        
        movieImageView.roundedCorner(corners: [.bottomLeft, .bottomRight], radius: 30)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseNetworkController.removeObserveDatabase(path: "comments/\(selectedMovie.id!)")
    }
    
    @IBAction func addButtonOnTapped(_ sender: Any) {
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
        return listOfComments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let commentViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentListCollectionViewCell
        
        let comment = listOfComments[indexPath.row]
        
        commentViewCell.bind(comment: comment)
        
        return commentViewCell
    }
    
    
}


//Create extension to conform UserAuthenticationNetwork
extension MovieViewController: UserAuthenticationNetworkControllerDelegate{
    func didReceiveUser(user: User) {
        currentUser = user
    }
}

//Create extension to conform DatabaseNetworkController
extension MovieViewController: DatabaseNetworkControllerDelegate{
    func watchListOfComments(comments: [Comment]) {
        self.listOfComments = comments
    }
}
