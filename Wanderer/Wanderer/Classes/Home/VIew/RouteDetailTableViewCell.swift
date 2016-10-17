//
//  RouteDetailTableViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/27.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SDWebImage

class RouteDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!

    @IBOutlet weak var detailLaebl: UILabel!
    @IBOutlet weak var bigImageView: UIImageView!
    
    @IBOutlet weak var clickView: UIView!
    var isOpen : Bool = true
    
    var indexPAth : NSIndexPath?
    var model : PointModel? {
        didSet {
            
            if isOpen {
                detailLaebl.hidden = false
                bigImageView.hidden = false
            } else {
                detailLaebl.hidden = true
                detailLaebl.hidden = true
            }
            
            if model!.icon_type == 2 {
                iconView.image = UIImage(named: "icon_plan_cell_attraction" )
            } else {
                iconView.image = UIImage(named: "icon_plan_cell_restaurant")
            }
            
            titleLabel.text = model!.topic
            tipsLabel.text = (model!.destination?.name)! + " · " + model!.address! + " · 建议游玩" + model!.visit_tip!
            detailLaebl.text = model!.introduce
            bigImageView.sd_setImageWithURL(NSURL(string: (model?.photo_url)!))
            layoutIfNeeded()
            if model?.cellHeight == 0 {
                model?.cellHeight = CGRectGetMaxY(detailLaebl.frame) + 20
            }
        }
    }
    
    var rankListModel : RankListModel? {
        didSet{
            if rankListModel!.icon_type == 2 {
                iconView.image = UIImage(named: "icon_plan_cell_attraction" )
            } else {
                iconView.image = UIImage(named: "icon_plan_cell_restaurant")
            }
            
            titleLabel.text = rankListModel!.topic
            tipsLabel.text = "\(rankListModel!.wishes_count)人想去"  + " · 建议游玩" + rankListModel!.visit_tip!
            detailLaebl.text = rankListModel!.introduce
            bigImageView.sd_setImageWithURL(NSURL(string: (rankListModel?.photo_url)!))
            layoutIfNeeded()
            if rankListModel?.cellHeight == 0 {
                rankListModel?.cellHeight = CGRectGetMaxY(detailLaebl.frame) + 20
            }

        }
    }
    
    
    
    class func getPointCell(tableView : UITableView) -> RouteDetailTableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("pointCell") as? RouteDetailTableViewCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("RouteDetailTableViewCell", owner: nil, options: nil).last as? RouteDetailTableViewCell
        }
        
        return cell!
    }
    
    
}
