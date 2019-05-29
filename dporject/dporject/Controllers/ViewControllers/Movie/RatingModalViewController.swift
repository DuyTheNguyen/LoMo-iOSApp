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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ratingUISilder(_ sender: UISlider) {
        //ratingValue = Double(round(10*sender.value)/10)
        ratingValue = Double(sender.value)
        ratingLabel.text = String(format: "%.1f", ratingValue)
        
    }
    @IBAction func cancelButtonOnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
