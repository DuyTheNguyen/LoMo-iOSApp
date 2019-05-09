//
//  User.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 24/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

struct User {
    let uid: String?
    let email: String?
    let password: String?
    let displayName: String?
    let photoURL: String?
    
    init(pUid: String? = nil, pEmail: String? = nil, pPassword:String? = nil, pDisplayName:String? = nil, pPhotoURL:String? = nil)
    {
        uid = pUid
        email = pEmail
        password = pPassword
        displayName = pDisplayName
        photoURL = pPhotoURL
    }
}
