//
//  Storage.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 6/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class StorageService{
    let storage = Storage.storage().reference()
    let meta = StorageMetadata()
    
   
    
    func uploadImage(folderName: String, imageFile: UIImage, fileName: String, completion: @escaping((Bool,String)->())){
       
        let ref = storage.child(folderName).child("\(fileName).png")
        
        meta.contentType = "image/png"
        
        guard let uploadData = imageFile.pngData() else {
            print("Image File is not PNG extension")
            return
        }
        
        //Upload data
        ref.putData(uploadData, metadata: meta, completion: { (metadata, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false, error?.localizedDescription ?? "Cannot uploaded")
                return
            }
            
            //download url
            ref.downloadURL(completion: { (url, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    completion(false, error?.localizedDescription ?? "Cannot uploaded")
                    return
                }
                
                guard let validURL = url else {
                    completion(false, "Invalid URL")
                    print("Invalid URL")
                    return
                }
                
                completion(true, validURL.absoluteString)
            })
            
        })
    }
}

