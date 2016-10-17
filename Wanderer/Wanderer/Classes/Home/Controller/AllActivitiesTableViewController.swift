//
//  AllActivitiesTableViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/16.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class AllActivitiesTableViewController: UITableViewController {

    var disID : NSNumber?
    
    var dataArray : [DestinationModel] = [DestinationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        reuqestData(1)
        
    }
    

}

extension AllActivitiesTableViewController {
    func setUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(kGlobelColor), forBarMetrics: .Default)
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .None
    
       self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.dataArray.removeAll()
            self.reuqestData(1)
       })
        
        self.tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: { 
            self.reuqestData(self.dataArray.count / 50 + 1)
        })
    }
    
    func reuqestData(page : Int) {
        SVProgressHUD.showWithStatus("正在加载网络数据")
        SVProgressHUD.setDefaultMaskType(.Black)
        NetWorkingTools.sharedInstance.requestUserAllActivityData((disID?.integerValue)!, page: page) { (result, error) in
        
            guard let resultDictArray = result else {
                SVProgressHUD.showErrorWithStatus("网络数据出错")
                return
            }
            for dict in resultDictArray {
                let model =  DestinationModel(dict: dict)
                model.isFull = true
                self.dataArray.append(model)
            }
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
                SVProgressHUD.dismiss()
            
        }
    }
}

extension AllActivitiesTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UserActivityCell.getCellWithTableView(tableView)
        
        cell.model = self.dataArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return dataArray[indexPath.row].cellHeight
    }
}
