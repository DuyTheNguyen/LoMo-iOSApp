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
    
    private var currentUser: User!
    private let userAuthenticationNetworkController = UserAuthenticationNetworkController();

    override func viewDidLoad() {
        super.viewDidLoad()
        userAuthenticationNetworkController.delegate = self
        userAuthenticationNetworkController.authenticationListener()
        
        //let contentWidth = scrollView.bounds.width
        //let contentHeight = scrollView.bounds.height * 3
        
        //scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
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
        
        mapView.roundedCorner(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 20)
    }

    
    @IBAction func addButtonOnTapped(_ sender: Any) {
        performSegue(withIdentifier: "movieToComment", sender: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if let commentViewController = segue.destination as? CommentViewController{
            guard let movie = selectedMovie else {
                fatalError("MovieViewController: cannot load movie" )
            }
            commentViewController.selectedMovie = movie
        }
    }
 

}

//Create extension to conform UserAuthenticationNetwork
extension MovieViewController: UserAuthenticationNetworkControllerDelegate{
    func didReceiveUser(user: User) {
        currentUser = user
    }
}
