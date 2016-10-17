//
//  RankListTableViewController.swift
//  Wanderer
//
//  Created by ÂàòÊù∞ on 16/9/28.
//  Copyright ¬© 2016Âπ¥ even. All rights reserved.
//

import UIKit
import SVProgressHUD

class RankListTableViewController: UITableViewController {
    
    var urlString : String?
    
    var modelArray : [DestinationModel] = [DestinationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        requestData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(1.0)), forBarMetrics: .Default)
   }

    
}
// MARK:- 请求数据和设置UI
extension RankListTableViewController {
    
    func setupUI() {
        self.tableView.rowHeight = 200
        tableView.backgroundColor = UIColor.getGlobeColorWithAlpha(1.0)
    }
    func requestData() {
        
        SVProgressHUD.setDefaultMaskType(.Black)
        SVProgressHUD.showWithStatus("正在加载网络数据")
        NetWorkingTools.sharedInstance.requestRankListData(urlString!) { (result, error) in
            if error != nil {
                print(error)
                return
            }
            
            for dict in result! {
                let model = DestinationModel(dict: dict)
                self.modelArray.append(model)
            }
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
    }
}

// MARK:- 代理与数据源
var y2 : CGFloat = -64
extension RankListTableViewController{
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(1 - offsetY / 64.0)), forBarMetrics: .Default)
        let cells = self.tableView.visibleCells as! [HomeTableViewCell]
        for cell in cells {
            let offsetY = (scrollView.contentOffset.y - y2) * (100 / (kScreenHeight + 200))
            cell.imageViewTopCons.constant += offsetY
        }
        y2 = scrollView.contentOffset.y
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("homeCell") as? HomeTableViewCell
        if cell == nil {
            cell =  HomeTableViewCell.getHomeTableViewCell()
        }
        cell!.model = self.modelArray[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? HomeTableViewCell
        let vc = RankListDetailTableViewController()
        vc.title = cell?.chineseLabel.text
        vc.id = (cell?.model?.id)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


