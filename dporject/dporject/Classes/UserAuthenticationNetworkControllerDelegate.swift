//
//  UserAuthenticationControllerDelegate.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 2/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

protocol UserAuthenticationNetworkControllerDelegate: class {
    func didReceiveUser(user: User)
}
