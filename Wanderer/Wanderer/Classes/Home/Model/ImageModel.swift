//
//  ImageModel.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/22.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import MJExtension

class ImageModel: NSObject {
    
    var photo_url : String?
    var topic : String?
    
    func mj_replacedKeyFromPropertyName121(propertyName: String!) -> AnyObject! {
        return ["photo_url":"photo.photo_url"]
    }

}
