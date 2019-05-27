//
//  TabBarController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 17/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        initialize()
    }
    
    private func initialize(){
        
        //Tranparent tab bar
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //Pop to root view if the controler is naviagtion
        if let viewController = viewController as? UINavigationController{
            viewController.popToRootViewController(animated: true)
        }
    }
    
    
}
