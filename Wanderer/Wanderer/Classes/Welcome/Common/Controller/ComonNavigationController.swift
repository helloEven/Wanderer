//
//  ComonNavigationController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/24.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class ComonNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.navigationBar.shadowImage = UIImage()
    }
    
 

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            
            let btn = UIButton(type:.Custom)
            btn.setBackgroundImage(UIImage(named: "ButtonBack_normal_24x24_"), forState: .Normal)
            btn.setBackgroundImage(UIImage(named: "ButtonBack_pressed"),forState:.Highlighted)
            btn.sizeToFit()
            btn.addTarget(self, action: #selector(ComonNavigationController.popViewControllerAnimated(_:)), forControlEvents: .TouchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
            viewController.hidesBottomBarWhenPushed = true
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
