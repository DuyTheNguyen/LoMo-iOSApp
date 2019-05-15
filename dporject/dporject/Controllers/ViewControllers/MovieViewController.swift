//
//  MovieViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 12/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movie: Movie? = nil
    
    fileprivate var currentUser = User(){
        didSet{
            print(currentUser)
        }
    }
        
    
    
    private let userAuthenticationNetworkController = UserAuthenticationNetworkController();

    override func viewDidLoad() {
        super.viewDidLoad()
        userAuthenticationNetworkController.delegate = self
        userAuthenticationNetworkController.authenticationListener()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(movie?.name)")
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

//Create extension to conform UserAuthenticationNetwork
extension MovieViewController: UserAuthenticationNetworkControllerDelegate{
    func didReceiveUser(user: User) {
        currentUser = user
    }
}
