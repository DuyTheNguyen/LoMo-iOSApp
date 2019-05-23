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
        modalUIView.roundedCorner(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 15)
        contentLabel.text = content
        confirmButton.setTitleColor(UIColor.white, for: .normal)
       
        switch alertType!{
        case AlertType.SUCCESS:
            titleLabel.text = AlertTitles.SUCCESS
            imageUIView.image = Icons.SUCCESS
            confirmButton.backgroundColor = CustomColors.GREEN
           
        case AlertType.FALIED:
            imageUIView.image = Icons.FAILED
            titleLabel.text = AlertTitles.FAILED
            confirmButton.backgroundColor = CustomColors.RED
       
        case AlertType.INFO:
            imageUIView.image = Icons.WARNING
            titleLabel.text = AlertTitles.INFO
            confirmButton.backgroundColor = CustomColors.YELLOW
            
        default:
            print("Should not be here")
        }
    }
    
    @IBAction func confirmButtonOnTapped(_ sender: Any) {
        
        dismiss(animated: true) {
            if self.alertType == AlertType.SUCCESS{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.CLOSE_UPDATE_MODAL), object: nil)
            }
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
