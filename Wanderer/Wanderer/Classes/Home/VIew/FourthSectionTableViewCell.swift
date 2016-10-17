//
//  FourthSectionTableViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/26.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class FourthSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: RankListCollectionView!
    
    @IBOutlet weak var collectionHeightCons: NSLayoutConstraint!
    var model : DestinationDetailModel? {
        didSet {
            titleLabel.text = model?.title
            collectionView.model = model
            collectionHeightCons.constant = (CGFloat)((model?.models1.count)!) * 140
            
            if model?.cellHeight == 0.0 {
                model?.cellHeight = (CGFloat)((model?.models1.count)!) * 140 + 30.0
            }
            
            layoutIfNeeded()
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSizeMake(kScreenWidth - 20, 120)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
        
        }
    }
    
    class func getCellWithTableView(tableview: UITableView) ->FourthSectionTableViewCell {
        var cell = tableview.dequeueReusableCellWithIdentifier("fourth") as? FourthSectionTableViewCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FourthSectionTableViewCell", owner: nil, options: nil).last as? FourthSectionTableViewCell
        }
        
        return cell!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

