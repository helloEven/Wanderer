//
//  DestinationDetailViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/26.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class DestinationDetailViewController: UIViewController {
    @IBOutlet weak var bgImageView: UIImageView!

    @IBOutlet weak var tableView: UITableView!

        
    var dataArray : [DestinationDetailModel] = [DestinationDetailModel]()
    
    var headerImageViewUrl : String?
    
    var idString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        requestData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.00)), forBarMetrics: .Default)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
     
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DestinationDetailViewController.showRouteDetailDestination(_:)), name: kShowRouteDetailBottonClick, object: nil)
       NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DestinationDetailViewController.jumpToNextDestination(_:)), name: kNearDestinationCollectionViewCellClick, object: nil)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
         NSNotificationCenter.defaultCenter().removeObserver(self, name:kNearDestinationCollectionViewCellClick, object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: kShowRouteDetailBottonClick, object: nil)
    }
    
    deinit {
        SVProgressHUD.dismiss()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
    
// MARK:- 设置UI和请求数据
extension DestinationDetailViewController {
    func setupUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.0)), forBarMetrics: .Default)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.separatorStyle = .None
        bgImageView.image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(headerImageViewUrl)
        
        tableView.estimatedRowHeight = 230
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DestinationDetailViewController.jumpToNextDestination(_:)), name: kNearDestinationCollectionViewCellClick, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DestinationDetailViewController.showRouteDetailDestination(_:)), name: kShowRouteDetailBottonClick, object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DestinationDetailViewController.showRankListVC(_:)), name:kRankListCollectionViewCellClick , object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DestinationDetailViewController.showUserInfo(_:)), name: kShowUserInfo, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DestinationDetailViewController.showALLAcititis(_:)), name: kShowAllAcivities, object: nil)
        
        
    }
    
    func requestData() {
        SVProgressHUD.showWithStatus("正在加载网络数据")
        NetWorkingTools.sharedInstance.requestDestinationDetailData(idString!) { (result, error) in
            if error != nil {
                SVProgressHUD.showErrorWithStatus("网络发生错误")
                return
            }
            
            
            for dict in result! {
                let model = DestinationDetailModel(dict: dict)
                self.dataArray.append(model)
            }
            
            SVProgressHUD.dismiss()
           self.tableView.reloadData()
        }
    }
    
    func showALLAcititis(note : NSNotification) {
        let obj = note.object as? NSNumber
        let vc = AllActivitiesTableViewController()
        vc.disID = obj
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func showUserInfo(note : NSNotification) {
        let obj = note.object as! DestinationDetailModel
        let vc = UserInfoTableViewController()
        vc.id = (obj.models1[0].user?.id)!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    func jumpToNextDestination(note : NSNotification) {
        let model = note.object as! DestinationModel
        
        let puVC = DestinationDetailViewController()
        puVC.title = model.name
        puVC.headerImageViewUrl = model.photo_url
        puVC.idString = "\(model.id)" + ".json"
        
        self.navigationController?.pushViewController(puVC, animated: true)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:kNearDestinationCollectionViewCellClick, object: nil)
       
        
    }
    
    func showRouteDetailDestination(note : NSNotification) {
        let model = note.object as! DestinationDetailModel
        
        let puVC = RouteDetailTableViewController()
        puVC.title = model.models1[0].title
        puVC.model = model
        
        self.navigationController?.pushViewController(puVC, animated: true)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kShowRouteDetailBottonClick, object: nil)
        
        
    }
    
    func showRankListVC(note : NSNotification) {
        let array = note.object as! [AnyObject]
        
        let vc =  RankListTableViewController()
        
        vc.title = array[1] as? String
        
        vc.urlString = "http://q.chanyouji.com/api/v1/activity_collections.json?destination_id=" + "\(array[0])"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
    
extension DestinationDetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = self.dataArray[indexPath.row]
        if model.type == kDestination {
            let cell = FirstSectionTableViewCell.getCellWithTableView(tableView)
            cell.model = model
            cell.selectionStyle = .None
            return cell
        } else if model.type == kPlan {
            let cell = SecondSectionTableViewCell.getCellWithTableView(tableView)
            cell.model = model
            cell.selectionStyle = .None
            return cell
        } else if model.type == kSearchActivityCollectionDestinationEntity || model.type == kActivityCollection {
            let cell = FourthSectionTableViewCell.getCellWithTableView(tableView)
            cell.model = model
            cell.selectionStyle = .None
            return cell
        } else {
            let cell = ThirdSectionTableViewCell.getCellWithTableView(tableView)
            cell.model = model
            cell.selectionStyle = .None
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.dataArray[indexPath.row].cellHeight
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y > 0 ? 0 : scrollView.contentOffset.y
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(1 - (-y / 64.0))), forBarMetrics: .Default)
    }
    
}

