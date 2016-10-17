//
//  RankListDetailHeaderView.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/11.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class RankListDetailHeaderView: UIView {
    
    var model : DestinationDetailModel? {
        didSet{
            introduceLabel.text = model?.desc
            
            if model?.headerHeight == 0.0 {
                layoutIfNeeded()
                model?.headerHeight = CGRectGetMaxY(introduceLabel.frame) + 40
            }
        }
    }

    @IBOutlet weak var introduceLabel: UILabel!
    
    class func getRankListDetailHeaderView() -> RankListDetailHeaderView{
        let headerView = NSBundle.mainBundle().loadNibNamed("RankListDetailHeaderView", owner: nil, options: nil).last as? RankListDetailHeaderView
        return headerView!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
