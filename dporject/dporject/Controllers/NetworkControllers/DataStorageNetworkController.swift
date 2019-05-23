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
    
    weak var delegate: DataStorageNetworkControllerDelegate?
    
    init() {
        storage = Storage.storage().reference()
    }
    
    func uploadFile(folderName: String, type: String, file: Any, fileName: String){
        let fileRef = storage?.child(folderName).child("\(fileName).png")
        let meta = StorageMetadata()
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
             fileRef?.putData(uploadData, metadata: meta, completion: { (metadata, error) in
                guard error != nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                
             })
            
        default:
            print("Should not be here though")
        }
       
       
    }
}
