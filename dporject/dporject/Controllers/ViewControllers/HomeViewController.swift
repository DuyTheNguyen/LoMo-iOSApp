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
    
    fileprivate var movies = [Movie](){
        didSet{
            print("HOME CONTROLLER")
            print(movies)
        }
    }

    @IBAction func signOutButtonTapped(_ sender: Any) {
        handleControllerTransitionWith(identifier: "SignInViewController")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.a
        print(Database.database().reference().child("popular"))
        
        databaseNetworkController.delegate = self
        databaseNetworkController.getDictionaryWith(path: "popular")
        
    }
    
    @IBAction func testButton(_ sender: Any) {
        databaseNetworkController.getDictionaryWith(path: "popular")
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

//Create extension to conform Delegate
extension HomeViewController: DatabaseNetworkControllerDelegate{
    func didReceivedDictionaryOfMovies(movies: [Movie]) {
        self.movies = movies
    }
}
