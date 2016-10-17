//
//  CategoryCollectionViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/15.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cateBtn: UIButton!
    var model : String? {
        didSet{
            cateBtn.setTitle(model, forState: .Normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        cateBtn.layer.cornerRadius = 15
        cateBtn.layer.masksToBounds = true
        cateBtn.userInteractionEnabled = false
    }

}
