//
//  StoreMap.swift
//  Order Drinks
//
//  Created by Stanley Tseng on 2019/12/22.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation : NSObject , MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordingnate:CLLocationCoordinate2D){
        self.coordinate = coordingnate
    }
}
