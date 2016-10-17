//
//  HomeTableViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/23.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    var model : DestinationModel? {
        didSet{
            pictureView.sd_setImageWithURL(NSURL(string: (model?.photo_url)!))
            
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(NSURL(string: (model?.photo_url)!), options:[] , progress: nil, completed: nil)
            
            if titleArray == nil {
                chineseLabel.text = model?.name
                englishLabel.text = model?.name_en
                
                if model?.name == nil {
                    chineseLabel.text = model?.topic
                    englishLabel.text = "- \((model?.inspiration_activities_count)!)条旅行灵感 -"
                }
            }
            
            imageViewTopCons.constant = -150
        }
    }
    
    var titleArray : [String]? {
        didSet{
            chineseLabel.text = titleArray![0]
            englishLabel.text = titleArray![1]
        }
    }
    
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var imageViewTopCons: NSLayoutConstraint!

    @IBOutlet weak var chineseLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
        
    }
    
    class func getHomeTableViewCell() -> HomeTableViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("HomeTableViewCell", owner: nil, options: nil).last as! HomeTableViewCell
        return cell
    }
}
