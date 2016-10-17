//
//  NearbyTableViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/17.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SDWebImage
class NearbyTableViewCell: UITableViewCell {
    
    
    var model : DestinationModel? {
        didSet{
            pictureImageView.sd_setImageWithURL(NSURL(string: (model?.near_photo_url)!))
            topicLabel.text = model?.topic
            addressLabel.text = model?.address
            wishCountLabel.text = "\((model?.wishes_count)!)人想去"
        }
    }
    
    @IBOutlet weak var pictureImageView: UIImageView!

    @IBOutlet weak var wishCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func getCellWithTableView(tableView : UITableView) -> NearbyTableViewCell {
        var  cell = tableView.dequeueReusableCellWithIdentifier("near") as? NearbyTableViewCell
        if cell == nil {
            cell = (NSBundle.mainBundle().loadNibNamed("NearbyTableViewCell", owner: nil, options: nil).last as! NearbyTableViewCell)
        }
        return cell!
    }
    
}
