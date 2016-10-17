//
//  UserHeaderView.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/15.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class UserHeaderView: UIView {

    @IBOutlet weak var bgImageView: UIImageView!

    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vLabel: UIImageView!
    @IBOutlet weak var genderLabel: UIImageView!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    
    var model : UserModel? {
        didSet{
            bgImageView.sd_setImageWithURL(NSURL(string: (model?.header_photo_url)!))
            iconImageView.sd_setImageWithURL(NSURL(string: (model?.photo_url)!))
            nameLabel.text = model?.name
            genderLabel.image = model?.gender == 0 ? UIImage(named: "gender0") : UIImage(named: "gender1")
            followingLabel.text = "\(model?.followings_count)关注"
            followerLabel.text = "\((model?.followers_count)!)粉丝"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 30
        iconImageView.layer.masksToBounds = true
    }
    
    class func getUserHeaderView() -> UserHeaderView{
        let headerView = NSBundle.mainBundle().loadNibNamed("UserHeaderView", owner: nil, options: nil).last as! UserHeaderView
        return headerView
    }
}
