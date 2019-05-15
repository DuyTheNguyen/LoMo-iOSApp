//
//  Extension.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 24/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController{
    func handleControllerTransitionWith(identifier: String){
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        weak var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        appDelegate?.window?.rootViewController = controller
        
    }
}






/************************************************
 *************** Begin: UIView ******************
 ************************************************/

//Rounded Bottom Corners
extension UIView{
    func roundedCorner (corners:UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


/************************************************
 *************** End: UIView ********************
 ************************************************/










/*************************************************
 *************** Begin: UIImageView **************
 *************************************************/

//Allow load image from URL
extension UIImageView {
    func load(imageString: String) {
        guard let url = URL(string: imageString) else{
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

/*************************************************
 *************** End: UIImageView ****************
 *************************************************/











/**********************************************************
 *************** Begin: UICollectionViewCell **************
 **********************************************************/

//Create cell with shadow and radius
extension UICollectionViewCell{
    func loadCustomisedCell(){
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
}

/********************************************************
 *************** End: UICollectionViewCell **************
 ********************************************************/











/************************************************
 *************** Begin: UILabel *****************
 ************************************************/

//Create label with shawdow and radius
extension UILabel{
    func loadCustomisedLabel(){
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        //self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
}

/************************************************
 *************** End: UILabel *******************
 ************************************************/





extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    func getCurrentDateInString()-> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return format.string(from: self)
    }
}
