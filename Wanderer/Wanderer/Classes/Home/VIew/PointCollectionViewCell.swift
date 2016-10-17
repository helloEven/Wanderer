//
//  PointCollectionViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/27.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class PointCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    var num : Int = 0 {
        didSet {
            numLabel.text = "\(num)"
        }
    }
    
    var model : String? {
        didSet {
            pointLabel.text = model
        }
    }
    
    func getCell() -> PointCollectionViewCell{
        let cell = NSBundle.mainBundle().loadNibNamed("PointCollectionViewCell", owner: nil, options: nil)?.last as? PointCollectionViewCell
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
