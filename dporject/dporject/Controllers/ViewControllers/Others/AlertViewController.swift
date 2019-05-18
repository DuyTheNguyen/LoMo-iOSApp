//
//  AlertViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 18/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    @IBOutlet weak var modalUIView: UIView!
    @IBOutlet weak var imageUIView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    private var alertType: AlertType!
    private var content: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUIComponents()
    }
    
    func bind(alertType: AlertType, content: String){
        self.alertType = alertType
        self.content = content
    }
    
    private func setUpUIComponents(){
        print(alertType)
        modalUIView.roundedCorner(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 15)
        contentLabel.text = content
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        switch alertType!{
        case AlertType.SUCCESS:
            titleLabel.text = "Yayy!! You did it!!"
            imageUIView.image = Icons.SUCCESS
            confirmButton.backgroundColor = UIColor.init(red: 76/255, green: 175/255, blue: 80/255, alpha: 0)
            
        case AlertType.FALIED:
            imageUIView.image = Icons.FAILED
            titleLabel.text = "Opps!! Something went wrong"
            confirmButton.backgroundColor = UIColor.init(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
        default:
            print("Should not be here")
        }
    }
    
    @IBAction func confirmButtonOnTapped(_ sender: Any) {
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
