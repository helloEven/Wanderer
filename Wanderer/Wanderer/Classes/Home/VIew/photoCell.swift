//
//  photoCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/16.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SDWebImage
class photoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var topicLabel: UILabel!
    
    var model : DestinationModel? {
        didSet{
            imageView.sd_setImageWithURL(NSURL(string: (model?.contents1[0].photo_url)!))
            topicLabel.text = model?.topic
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
