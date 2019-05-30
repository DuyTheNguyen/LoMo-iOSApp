//
//  RatingViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 29/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class RatingModalViewController: UIViewController {

    @IBOutlet weak var ratingLabel: UILabel!
    var ratingValue: Double = 0.0
    
    var selectedMovie: Movie!
    fileprivate var currentUser: User!
    private var isRatingAdded: Bool = false
    
    private let userNetworkController = UserNetworkController()
    private let databaseNetworkController = DatabaseNetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    private func initialize(){
        userNetworkController.delegate = self
        userNetworkController.authenticationListener()
        
        databaseNetworkController.delegate = self
    }
    
    @IBAction func ratingUISilder(_ sender: UISlider) {
        //ratingValue = Double(round(10*sender.value)/10)
        ratingValue = Double(sender.value)
        ratingLabel.customiseTextBasedOnRatingValue(score: ratingValue)
        //ratingLabel.text = String(format: "%.1f", ratingValue)
        
    }
    @IBAction func cancelButtonOnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonOnTapped(_ sender: Any) {
        
        let rating = Rating(userId: currentUser.uid!, value: ratingValue)
        
        databaseNetworkController.addRating(movieId: selectedMovie.id!, rating: rating)
        
        if isRatingAdded{
            dismiss(animated: true, completion: nil)
        }else{
            print("Could not rating")
        }
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
extension RatingModalViewController: UserNetworkControllerDelegate{
    func didReceiveUser(user: User){
        self.currentUser = user
    }
}

extension RatingModalViewController: DatabaseNetworkControllerDelegate{
    func isRatingAdded(isIt: Bool){
        self.isRatingAdded = isIt
    }
}











