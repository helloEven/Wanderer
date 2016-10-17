//
//  MeHeaderView.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/17.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class MeHeaderView: UIView {

    @IBOutlet weak var nameLabel: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBAction func login(sender: UIButton) {
        let vc = LoginController()
        self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    class func getHeaderView() -> MeHeaderView {
        let view = NSBundle.mainBundle().loadNibNamed("MeHeaderView", owner: nil, options: nil).last as! MeHeaderView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 24
        iconImageView.layer.masksToBounds = true
    }

}
