//
//  DatabaseNetworkControllerDelegate.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
protocol DatabaseNetworkControllerDelegate: class{
    func didReceivedDictionaryOfMovies(movies : [Movie])
}

