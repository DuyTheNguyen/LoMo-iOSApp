//
//  Extension.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 24/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
import Foundation
import MapKit

extension UIViewController{
    func handleControllerTransitionWith(identifier: String){
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        weak var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        appDelegate?.window?.rootViewController = controller
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
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
    
    
    //Activity Indicator
    func startIndicatorAnnimation(activityColor: UIColor? = UIColor.white, backgroundColor: UIColor? = UIColor.black.withAlphaComponent(0.5)) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = ViewTags.INDICATOR_VIEW
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func stopIndicatorAnnimation() {
        if let background = viewWithTag(ViewTags.INDICATOR_VIEW){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
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
    
    func setUpImageViewWithIcons(type: String){
        var image: UIImage!
        switch(type){
        case "name":
            image = Icons.NAME
        case "password":
            image = Icons.PASSWORD
        case "email":
            image = Icons.EMAIL
        default:
            image = Icons.EDIT_ADD
        }
        self.image = image
    }
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}
/*************************************************
 *************** End: UIImageView ****************
 *************************************************/






/*******************************************************
 *************** Begin: CustomUIImageView **************
 *******************************************************/
let imageCache = NSCache<AnyObject, AnyObject>()
class CustomUIImageView: UIImageView{
    var imageStringURL: String?
    func load(urlString: String, cacheImage: Bool! = true) {
        
        guard let url = URL(string: urlString) else{
            return
        }
        
        imageStringURL = urlString
        self.startIndicatorAnnimation()
        image = nil
        
        //Check whether cache image exsits
        if cacheImage{
            if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
             self.image = imageFromCache
             self.stopIndicatorAnnimation()
             return
            }
        }
        
        DispatchQueue(label: "Image Processing Queue").async {
            guard let data = try? Data(contentsOf: url) else{
                print("No data")
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("No Image")
                return
            }
            
          
             DispatchQueue.main.async {
                let imageToCache = image
                //Dont show up previous images
                guard self.imageStringURL == urlString else{
                    self.stopIndicatorAnnimation()
                    return
                }
                self.image = imageToCache
                if cacheImage{
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                }
                self.stopIndicatorAnnimation()
             }
        }
    }
}
/*****************************************************
 *************** End: CustomUIImageView **************
 *****************************************************/







/**********************************************************
 *************** Begin: UICollectionViewCell **************
 **********************************************************/

//Create cell with shadow and radius
extension UICollectionViewCell{
    func loadCustomCell(widthCornerRadius: CGFloat){
        self.contentView.layer.cornerRadius = widthCornerRadius
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
    func loadCustomLabel(){
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
    
    /**
     Return the rating bar based on score
     - Parameter score: your score
     */
    func setRatingStars(ratingList:[Rating]){
        var total = 0.0
        for rating in ratingList{
            total += rating.value!
        }
        
        total = total/Double(ratingList.count)
        
        var result = ""
        
        let dScore = total.rounded(.toNearestOrAwayFromZero)
        let sTotal = String(format: "%.1f", total)
        
        guard dScore != 0 else{
            result = "😱"
            self.text = "\(result) \(sTotal) - \(ratingList.count) vote(s)"
            return
        }
    
        for _ in 1...Int(dScore){
            result += "⭐️"
        }
        
        self.text = "\(result) \(sTotal) - \(ratingList.count) vote(s)"
    
    }
    
    func generateAverage(ratingLists: [Rating])->String{
        var total = 0.0
        for rating in ratingLists{
            total += rating.value!
        }
        
        return "\(total/Double(ratingLists.count))"
    }
    
    ///  Return text color and size based on the score
    ///- Parameter score: your score
    func customiseTextBasedOnRatingValue(score: Double){
        var emo = "🥺"
        if score < 5.0 {
            self.textColor = CustomColors.RED
            self.font = self.font.withSize(25)
        } else if score < 8.0{
            self.textColor = CustomColors.YELLOW
            self.font = self.font.withSize(30)
            emo = "😎"
        }else if score <= 10.0{
            self.textColor = CustomColors.GREEN
            self.font = self.font.withSize(35)
            emo = "🤩"
        }
        self.text = String(format: "%@ %.1f", emo, score)
    }
}
/************************************************
 *************** End: UILabel *******************
 ************************************************/







/************************************************
 *************** Start: UISlider ****************
 ************************************************/
extension UISlider{
    func customiseSliderColorBasedOnRatingValue(score: Double){
        if score < 5.0 {
            self.minimumTrackTintColor = CustomColors.RED
            self.thumbTintColor = CustomColors.RED
        } else if score < 8.0{
            self.minimumTrackTintColor = CustomColors.YELLOW
            self.thumbTintColor = CustomColors.YELLOW
        }else if score <= 10.0{
            self.minimumTrackTintColor = CustomColors.GREEN
            self.thumbTintColor = CustomColors.GREEN
        }
    }
}
/************************************************
 *************** End: UISlider ******************
 ************************************************/






/******************************************************
 *************** Begin: UICollectionView **************
 ******************************************************/
extension UICollectionView {
    func scrollToLast() {
        guard numberOfSections > 0 else {
            return
        }
        
        let lastSection = numberOfSections - 1
        
        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }
        
        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
    
    func scrollToFirst(){
        self.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .top, animated: true)
    }
    
    
    /**
     Set custom message if the list is empty
     - Parameter message: your custom message
     
     */
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
       
        self.backgroundView = messageLabel
    }
    
    /**
     Reset the background
     */
    func restore() {
        self.backgroundView = nil
        
    }
}

extension UIButton{
    func buttonWithText(title:String, iconName: UIImage){
        self.setTitle(title, for: .normal)
        self.setImage(iconName, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
    }
}


extension UINavigationController{
    func setNavbarTransparent(){
        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
}


extension MKMapView{
    func centerMapOnLocationWithCoordinate(regionRadius: CLLocationDistance, latitude: String? = nil, longitude:String? = nil){
        let latitudeD = Double(latitude ?? "-37.8220633")
        let longitudeD =  Double(longitude ?? "144.9941035")
        
        let location = CLLocation(latitude: latitudeD!, longitude: longitudeD!)
        
        
        //Create and add coordinate region to the map view
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
        
    }
}
/******************************************************
 *************** Begin: UICollectionView **************
 ******************************************************/







/************************************************
 *************** Begin: String *****************
 ************************************************/
extension String{
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func fromTimeStampToCustomDate() -> String{
        guard let myTimeInterval = TimeInterval(self) else {
            return("Could not convert from string to time interval")
        }
        
        let time = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
       return formatter.string(from: time as Date)
    }
    
    func fromTimeStampToDouble() -> Double{
        return Double(self) ?? 0.0
    }
    
   
}
/************************************************
 *************** End: String *******************
 ************************************************/
