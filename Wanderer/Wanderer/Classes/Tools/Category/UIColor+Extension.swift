//
//  UIColor+Extension.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/23.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
extension UIColor {
    class func getGlobeColorWithAlpha(alpha:CGFloat) ->UIColor {
        return UIColor(red: 70 / 255.0, green: 173 / 255.0, blue: 199 / 255.0, alpha: alpha)
    }
    
    class func getColorWithAlpha(color : UIColor,alpha : CGFloat) -> UIColor {
        return color.colorWithAlphaComponent(alpha)
    }
}
