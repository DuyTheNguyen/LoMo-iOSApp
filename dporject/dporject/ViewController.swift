//
//  ViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 14/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    var dataRef  : DatabaseReference!
    var emailRef: DatabaseReference!
    
    
    @IBAction func nameChangeTapped(_ sender: Any) {
          emailRef.setValue(emailTextField.text)
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataRef = Database.database().reference()
        emailRef = dataRef.child("someid/name")
        
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailRef!.observe(DataEventType.value, with: { (snapshot) in
            self.emailLabel.text = snapshot.value as! String
            
        })
    }
    
}

