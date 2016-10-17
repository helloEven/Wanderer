//
//  HeaderView.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/24.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    var url : String? {
        didSet {
            
            imageView.sd_setImageWithURL(NSURL(string: url!))
        }
    }
    
    class func getHeaderView() -> HeaderView {
        let headerView = NSBundle.mainBundle().loadNibNamed("HeaderView", owner: nil, options: nil).last as! HeaderView
        return headerView
    }
    

}
