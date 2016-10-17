//
//  ShareView.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/16.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class ShareView: UIView {

    @IBOutlet weak var topImageView: UIImageView!

    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var model : DestinationModel? {
        didSet{
            topImageView.sd_setImageWithURL(NSURL(string: (model?.contents1[0].photo_url)!))
            topicLabel.text = model?.topic
            nameLabel.text = "@" + (model?.user?.name)!
            desLabel.text = model?.des
            locationLabel.text = model?.name
            
            if model?.shareViewHeight == 0.0 {
                layoutIfNeeded()
                model?.shareViewHeight = CGRectGetMaxY(locationLabel.frame) + 20
            }
        }
    }
    
    class func getView() -> ShareView{
        let view = NSBundle.mainBundle().loadNibNamed("ShareView", owner: nil, options: nil).last as! ShareView
        return view
    }
}
