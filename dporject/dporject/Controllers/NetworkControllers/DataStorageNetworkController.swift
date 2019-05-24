//
//  DataStorageController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 23/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class DataStorageNetworkController{
    private let storage: StorageReference?
    private let userNetworkController = UserNetworkController()
    
    private var message = String(){
        didSet{
            self.delegate?.didUpload(isUpdated: isUpdated, message: message)
        }
    }
    private var isUpdated: Bool!
    
    weak var delegate: DataStorageNetworkControllerDelegate?
    
    init() {
        storage = Storage.storage().reference()
        userNetworkController.delegate = self
    }
    
    func uploadFile(folderName: String, type: String, file: Any, fileName: String){
        let meta = StorageMetadata()
        guard let fileRef = storage?.child(folderName).child("\(fileName).png") else {
            print("Could not generate file reference")
            return
        }
       
        switch type{
        case "image/png":
             meta.contentType = "image/png"
             guard let imageFile = file as? UIImage else {
                print("File is not an image")
                return
             }
            
             guard let uploadData = imageFile.pngData() else {
                print("Image File is not PNG extension")
                return
             }
            
            //Upload data
             fileRef.putData(uploadData, metadata: meta, completion: { (metadata, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                //Update user profile
                fileRef.downloadURL(completion: { (url, error) in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    guard let validURL = url else {
                        print("Invalid URL")
                        return
                    }
                    self.userNetworkController.updateProfile("photoURL", withValue: validURL.absoluteString)
                    
                })
                
             })
            
        default:
            print("Should not be here though")
        }
    }
    
    
}

//Create extension to conform Delegate
extension DataStorageNetworkController:UserNetworkControllerDelegate{
    func updateData(isUpdated: Bool, message: String) {
        self.isUpdated = isUpdated
        self.message = message
    }
}
