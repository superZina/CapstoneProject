//
//  BusStop.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import MapKit

class BusStop: NSObject,MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle:String){
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
    }

}
