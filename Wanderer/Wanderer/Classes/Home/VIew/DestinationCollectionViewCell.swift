//
//  DestinationCollectionViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/26.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class DestinationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pictureView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    
    var model : DestinationModel? {
        didSet {
            pictureView.sd_setImageWithURL(NSURL(string: (model?.photo_url)!))
            nameLabel.text = model?.name
            englishNameLabel.text = model?.name_en
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
