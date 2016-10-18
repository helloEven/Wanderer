//
//  UserInfoTableViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/15.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
class UserInfoTableViewController: UITableViewController {
    
    var id : Int = -1
    var userModel : UserModel? = UserModel()
    var dataArray : [DestinationModel] = [DestinationModel]()
    var image : UIImage = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        requestData()
    
    }

    
}

// MARK:- 设置UI和请求数据
extension UserInfoTableViewController {
    func setupUI() {
        
        let btn = UIButton(type: .Custom)
        btn.setBackgroundImage(UIImage(named: "icon_map_20x20_"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "icon_map_selected_20x20_"), forState: .Highlighted)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(UserInfoTableViewController.showMapPicture), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.separatorStyle = .None
        
    }
    
    func showMapPicture() {
        let vc = MapPictureViewController()
        vc.models = dataArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestData() {
        SVProgressHUD.showWithStatus("正在加载网络数据")
        SVProgressHUD.setDefaultMaskType(.Black)
        NetWorkingTools.sharedInstance.requestUserInfoData("\(id)") { (result, error) in
            guard let resultDict = result else {
                SVProgressHUD.showErrorWithStatus("网络数据错误")
                return
            }
            
            self.userModel = UserModel(dict: resultDict)
            
            
            

            
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(NSURL(string: self.userModel!.photo_url!), options: [], progress: nil, completed: { (_, _, _, _) in
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let headerView = UserHeaderView.getUserHeaderView()
                    headerView.height = 200
                    headerView.model = self.userModel
                    self.tableView.tableHeaderView = headerView
                    
                    headerView.iconImageView.image = UIImageTool.imageWithBorder(5, color: UIColor.whiteColor(), image: SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(self.userModel!.photo_url))
                    self.tableView.reloadData()
                })
                
            })
            
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(NSURL(string: self.userModel!.header_photo_url!), options: [], progress: nil, completed: { (image, _, _, _) in
                //print(self.userModel!.header_photo_url)
                dispatch_async(dispatch_get_main_queue(), { 
                    self.image = image
                    self.tableView.reloadData()
                })
                
            })
            
            
            
            
        }

        NetWorkingTools.sharedInstance.requestUserActivityData("\(id)") { (result, error) in
            guard let resultDict = result else {
                return
            }
            
            for dict in resultDict {
                if let activityArray = dict["activities"] as? [[String : AnyObject]] {
                    for activityDict in activityArray {
                        self.dataArray.append(DestinationModel(dict: activityDict))
                    }
                }
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
        
    }
}

extension UserInfoTableViewController {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let image = UIImage.getBottomImage(self.image) == nil ? UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.0)) :  UIImage.getBottomImage(self.image)
        
        if scrollView.contentOffset.y >= 136 {
            self.navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.0)), forBarMetrics: .Default)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UserActivityCell.getCellWithTableView(tableView)
        cell.model = dataArray[indexPath.row]
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return dataArray[indexPath.row].cellHeight
    }
}
