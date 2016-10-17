//
//  PicttureCollectionViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/14.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SVProgressHUD
class PicttureCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    var model : String? {
        didSet {
            imageView.sd_setImageWithURL(NSURL(string: model!), placeholderImage: nil, options: [], progress: { (current, total) in

                SVProgressHUD.showProgress(Float(current) / Float(total))
                }) { (_, _, _, _) in
                    SVProgressHUD.dismiss()
            }
        }
    }
    
    var model1 : String? {
        didSet {
            imageView.sd_setImageWithURL(NSURL(string: model1!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
