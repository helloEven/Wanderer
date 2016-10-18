//
//  RankListDetailTableViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/11.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SVProgressHUD

class RankListDetailTableViewController: UITableViewController {
    
    var id : Int = -1
    
    var model : DestinationDetailModel = DestinationDetailModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.9999)), forBarMetrics: .Default)
    }
    
    
}

// MARK:- 设置UI和请求数据
extension RankListDetailTableViewController {
    func setupUI() {
        tableView.estimatedRowHeight = 400
        self.tableView.backgroundColor = UIColor.getGlobeColorWithAlpha(1.0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        tableView.separatorColor = UIColor(colorLiteralRed: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 20)

        
    }
    
    func requestData() {
        SVProgressHUD.setDefaultMaskType(.Black)
        SVProgressHUD.showWithStatus("正在加载网络数据")
        NetWorkingTools.sharedInstance.requestRankListDetailData("\(id)" + ".json") { (result, error) in
            if error != nil {
    
                SVProgressHUD.showErrorWithStatus("网络数据出错")
                return
            }
            self.model = DestinationDetailModel.init(dict: result!)
            
            
            // 设置header
            let  headerView = RankListDetailHeaderView.getRankListDetailHeaderView()
            headerView.model = self.model
            headerView.height = (self.model.headerHeight)
            
            self.tableView.tableHeaderView = headerView
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
}

// MARK:- 数据源和代理
extension RankListDetailTableViewController {
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(1 - offsetY / 64.0)), forBarMetrics: .Default)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model.inspirations1.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = RouteDetailTableViewCell.getPointCell(tableView)
        
        cell.rankListModel = model.inspirations1[indexPath.row]
        
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (model.inspirations1[indexPath.row].cellHeight)
    }
}