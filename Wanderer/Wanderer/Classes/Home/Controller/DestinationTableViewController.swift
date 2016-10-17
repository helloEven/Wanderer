//
//  ChinaTableViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/23.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class DestinationTableViewController: UITableViewController {
    
    var destinations : [DestinationModel] = [DestinationModel]()
    var titleArray : [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    
    


}

// MARK:- 代理与数据源
var y1 : CGFloat = -64
extension DestinationTableViewController {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(1 - offsetY / 64.0)), forBarMetrics: .Default)
        let cells = self.tableView.visibleCells as! [HomeTableViewCell]
        for cell in cells {
            let offsetY = (scrollView.contentOffset.y - y1) * (100 / (kScreenHeight + 200))
            cell.imageViewTopCons.constant += offsetY
        }
        y1 = scrollView.contentOffset.y

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "homeCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? HomeTableViewCell
            if  cell == nil {
            cell = HomeTableViewCell.getHomeTableViewCell()
            }
            cell!.model = destinations[indexPath.row]
            return cell!
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? HomeTableViewCell
        
        let model = self.destinations[indexPath.row] as DestinationModel
        
        
        let puVC = DestinationDetailViewController()
        puVC.title = cell!.chineseLabel.text
        puVC.headerImageViewUrl = model.photo_url
        puVC.idString = "\(model.id)" + ".json"
        
        self.navigationController?.pushViewController(puVC, animated: true)
    }
}


// MARK:- 设置UI
extension DestinationTableViewController {
    func setupUI() {
        self.title = titleArray[0]
        tableView.rowHeight = 200
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(kGlobelColor), forBarMetrics: .Default)
        
        self.tableView.backgroundColor = UIColor.getGlobeColorWithAlpha(1.0)

    }
    
}

