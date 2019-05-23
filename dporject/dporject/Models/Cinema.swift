//
//  Cinema.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 20/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Cinema: NSObject, MKAnnotation{
    
    var address: String!
    var id: String!
    var latitude: String!
    var longitude: String!
    var name: String!
    
    init(address: String, id: String, userName: String, latitude: String, longitude: String, name: String){
        self.address = address
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        super.init()
    }
    
    init(snapshot: AnyObject){
        self.address = snapshot["address"] as? String
        self.id = snapshot["id"] as? String
        self.latitude = snapshot["latitude"] as? String
        self.longitude = snapshot["longitude"] as? String
        self.name = snapshot["name"] as? String
        super.init()
    }
    
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
    }
    var title:String?{
        return name
    }
    
    var subtitle: String? {
        return address
    }
}
