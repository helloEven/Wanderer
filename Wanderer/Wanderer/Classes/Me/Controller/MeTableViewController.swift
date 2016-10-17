//
//  MeTableViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/21.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class MeTableViewController: UITableViewController {
    
    var isMotioned : Bool = false
    
    var headerView : MeHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if isMotioned == true {
            AudioTool.playAudio("5018.wav", isAlert: true, completion: {
                
            })
            
            let vc = NearbyTableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}

extension MeTableViewController {
    func setupUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.0)), forBarMetrics: .Default)
        
        self.headerView = MeHeaderView.getHeaderView()
        self.headerView!.height = 200
        self.tableView.tableHeaderView = headerView
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MeTableViewController.login(_:)), name: kLogin, object: nil)
        
    }
    
    func login(note : NSNotification) {
        let noteDict = note.object as? [String : AnyObject]
        if let name  = noteDict!["name"] as? String {
            self.headerView?.nameLabel.setTitle(name, forState: .Normal)
        }
        if let url = noteDict!["url"] as? String {
            self.headerView?.iconImageView.sd_setImageWithURL(NSURL(string: url))
        }
        self.tableView.reloadData()
    }
}

extension MeTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 && indexPath.row == 1 {
            let size = SDWebImageManager.sharedManager().imageCache.getSize() / (1000  * 1000)
            SDWebImageManager.sharedManager().imageCache.cleanDiskWithCompletionBlock({
                SVProgressHUD.setDefaultStyle(.Dark)
                SVProgressHUD.showSuccessWithStatus("清理缓存\(size)M")
            })
        } else if indexPath.section == 2 && indexPath.row == 2 {
            self.isMotioned = true
        }
    }
}
