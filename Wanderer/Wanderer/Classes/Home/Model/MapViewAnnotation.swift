//
//  MapViewAnnotation.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/27.
//  Copyright © 2016年 even. All rights reserved.
//

import MapKit

class MapViewAnnotation: NSObject, MKAnnotation{
    // 确定大头针砸在哪个位置
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    
    // Title and subtitle for use by selection UI.
    // 弹框的标题
    var title: String?
    // 弹框的子标题
    var subtitle: String?
}
