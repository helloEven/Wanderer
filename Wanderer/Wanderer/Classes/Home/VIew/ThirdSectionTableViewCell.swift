//
//  ThirdSectionTableViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/24.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class ThirdSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bottomBtn: UIButton!
    
    
    @IBOutlet weak var imageViewHeightCons: NSLayoutConstraint!
    var model : DestinationDetailModel? {
        didSet{
            let content = model?.models1[0].contents1[0]
            imageViewHeightCons.constant = (content?.height)! / ((content?.width)! / (kScreenWidth - 20))
            pictureView.sd_setImageWithURL(NSURL(string: (content?.photo_url)!))
            
            iconView.layer.cornerRadius = 20
            iconView.layer.masksToBounds = true
            iconView.sd_setImageWithURL(NSURL(string: (model?.models1[0].user?.photo_url)!))
            nameLabel.text = model?.models1[0].user?.name
            topicLabel.text = model?.models1[0].topic
            contentLabel.text = model?.models1[0].summary
            bottomBtn.setTitle(model?.button_text, forState: .Normal)
            
            if model!.cellHeight == 0.0 {
                layoutIfNeeded()
                model!.cellHeight = CGRectGetMaxY(bottomBtn.frame) + 40
            }
            
        }
    }
    
    @IBAction func showAllAcivities(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName(kShowAllAcivities, object: model?.models1[0].district_id)
        
    }
    class func getCellWithTableView(tableview: UITableView) ->ThirdSectionTableViewCell {
        var cell = tableview.dequeueReusableCellWithIdentifier("third") as? ThirdSectionTableViewCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("ThirdSectionTableViewCell", owner: nil, options: nil).last as? ThirdSectionTableViewCell
        }
        
        return cell!
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pictureView.userInteractionEnabled = true
        pictureView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ThirdSectionTableViewCell.showAllPicture)))
        iconView.userInteractionEnabled = true
        iconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ThirdSectionTableViewCell.showUserInfo)))
        
    }
    
    func showUserInfo() {
        NSNotificationCenter.defaultCenter().postNotificationName(kShowUserInfo, object: model)
    }
    
    func showAllPicture() {
        
        let vc = ShowAllPictureViewController()
        vc.model = model?.models1[0]
        vc.modalPresentationStyle = .OverCurrentContext
        self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
    }

    
}
