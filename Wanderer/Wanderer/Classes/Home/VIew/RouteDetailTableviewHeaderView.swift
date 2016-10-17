//
//  RouteDetailTableviewHeaderView.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/27.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class RouteDetailTableviewHeaderView: UIView {
    
    var num :Int = 0
    var model : DayMoodel? {
        didSet {
            dayDescriptionLabel.text = model?.desc
            dayTitleBtn.setTitle("DAY\(num)" + (model?.points1[0].destination!.name)!, forState: .Normal)
            
            if model?.headerHeight == 0 {
                layoutIfNeeded()
                model?.headerHeight = CGRectGetMaxY(dayDescriptionLabel.frame) + 20
            }
        }
    }
    
    class func getsectionHeaderView() -> RouteDetailTableviewHeaderView {
        let header = NSBundle.mainBundle().loadNibNamed("RouteDetailTableviewHeaderView", owner: nil, options: nil).last as! RouteDetailTableviewHeaderView
        return header
    }

    @IBOutlet weak var dayTitleBtn: UIButton!

    @IBOutlet weak var dayDescriptionLabel: UILabel!

}
