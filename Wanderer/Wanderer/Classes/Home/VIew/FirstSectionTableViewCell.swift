//
//  FirstSectionTableViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/24.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class FirstSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: DestinationCollectionView!
    
    var model : DestinationDetailModel? {
        didSet {
            titleLabel.text = model!.title
            
            guard let models = model?.models1 else {
                return
            }
            
    
            collectionView.dataArray = models
            
            
            
            if model!.cellHeight == 0.0 {
                model!.cellHeight = 230
            }
            
        }
    }
    
    // 返回cell的函数
    class func getCellWithTableView(tableview: UITableView) ->FirstSectionTableViewCell {
        var cell = tableview.dequeueReusableCellWithIdentifier("first") as? FirstSectionTableViewCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FirstSectionTableViewCell", owner: nil, options: nil).last as? FirstSectionTableViewCell
        }
        
        return cell!
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
