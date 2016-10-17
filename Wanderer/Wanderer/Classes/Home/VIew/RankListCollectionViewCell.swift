//
//  RankListCollectionViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/28.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class RankListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var summeryLabel: UILabel!
    @IBOutlet weak var titleLaebl: UILabel!
    @IBOutlet weak var bigImageView: UIImageView!
    
    var model : DestinationModel? {
        didSet {
            titleLaebl.text = model?.title
            bigImageView.sd_setImageWithURL(NSURL(string: (model?.photo_url)!))
            
            summeryLabel.text = model?.summary
        }
    }
    
    func getCell() -> RankListCollectionViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed(nil, owner: nil, options: nil).last as! RankListCollectionViewCell
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
