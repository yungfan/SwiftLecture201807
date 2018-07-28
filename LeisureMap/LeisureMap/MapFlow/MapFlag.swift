//
//  MapFlag.swift
//  LeisureMap
//
//  Created by 房懷安 on 2018/7/26.
//  Copyright © 2018年 房懷安. All rights reserved.
//

import Foundation
import MapKit

// MARK: - Annotation - 大头针模型
class MapFlag: NSObject, MKAnnotation {
    
    let title: String?
    
    let locationName: String
    
    let discipline: String
    
    let coordinate: CLLocationCoordinate2D
    
    let urlString:String
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, url : String) {
        
        self.title = title
        
        self.locationName = locationName
        
        self.discipline = discipline
        
        self.coordinate = coordinate
        
        self.urlString = url
        
        super.init()
    }
    
    var subtitle: String? {
        
        return locationName
    }
}
