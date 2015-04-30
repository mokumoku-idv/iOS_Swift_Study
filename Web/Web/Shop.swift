//
//  Shop.swift
//  Web
//
//  Created by pomn on 4/30/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit
import MapKit

class Shop: NSObject, MKAnnotation {
    let title: String
    let subtitle: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
//    var subtitle: String {
//        return locationName
//    }
}
