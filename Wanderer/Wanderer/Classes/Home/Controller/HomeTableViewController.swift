//
//  HomeTableViewController.swift
//  Wanderer
//
//  Created by ÂàòÊù∞ on 16/9/21.
//  Copyright ¬© 2016Âπ¥ even. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import AFNetworking
import MJRefresh
import MapKit
import CoreLocation

class HomeTableViewController: UITableViewController {
    lazy var chinaDestination : [DestinationModel] = [DestinationModel]()
    lazy var tWAMXGDetination : [DestinationModel] = [DestinationModel]()
    lazy var europeDestination : [DestinationModel] = [DestinationModel]()
    lazy var otherDestination : [DestinationModel] = [DestinationModel]()
    lazy var asianDestination : [DestinationModel] = [DestinationModel]()
    lazy var dataArray : [DestinationModel] = [DestinationModel]()
    var titleArray : [[String]] = [[String]]()
    
    lazy var cllocationM : CLLocationManager = {
        let cllocationM = CLLocationManager()
        cllocationM.requestAlwaysAuthorization()
        return cllocationM
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = cllocationM
        
        setupUI()
        
        
        requestData()
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.dataArray.count == 5 {
            SVProgressHUD.dismiss()
        }

    }

    
}
// MARK:- ËØ∑Ê±ÇÁΩëÁªúÊï∞ÊçÆ
extension HomeTableViewController {
    func requestData() {
        self.dataArray.removeAll()
        self.asianDestination.removeAll()
        self.chinaDestination.removeAll()
        self.otherDestination.removeAll()
        self.europeDestination.removeAll()
        self.tWAMXGDetination.removeAll()
        SVProgressHUD.showWithStatus("正在加载网络数据")
        let group = dispatch_group_create()
        dispatch_group_enter(group)
        NetWorkingTools.sharedInstance.requestChinaHotDestinationData { (result, error) in
            guard let resultArray = result else {
                return
            }
            for dict in resultArray {
                self.chinaDestination.append(DestinationModel(dict: dict))
            }
            self.dataArray.append(self.chinaDestination[0])
            self.titleArray.append(["熟悉的大陆风景","China"])
            self.tableView.reloadData()
            
        }
        
        NetWorkingTools.sharedInstance.requestTWAMXGData { (result, error) in
            guard let resultArray = result else {
                return
            }
            for dict in resultArray {
                self.tWAMXGDetination.append(DestinationModel(dict: dict))
            }
            self.dataArray.append(self.tWAMXGDetination[0])
            self.titleArray.append(["迷人的港澳台风景","HK,TW,AM"])
            self.tableView.reloadData()
        }
        
        NetWorkingTools.sharedInstance.requestAisianHotDestinationData { (result, error) in
            guard let resultArray = result else {
                return
            }
            for dict in resultArray {
                self.asianDestination.append(DestinationModel(dict: dict))
            }
            self.dataArray.append(self.asianDestination[0])
            self.titleArray.append(["神往的亚洲风景","Asian"])
            self.tableView.reloadData()
        }
        
        NetWorkingTools.sharedInstance.requestEuropeHotDestinationData { (result, error) in
            guard let resultArray = result else {
                return
            }
            for dict in resultArray {
                self.europeDestination.append(DestinationModel(dict: dict))
            }
            self.dataArray.append(self.europeDestination[0])
            self.titleArray.append(["浪漫的欧洲风景","Europe"])
            self.tableView.reloadData()
            
        }
        
        NetWorkingTools.sharedInstance.requestOtherHotDestinationData { (result, error) in
            guard let resultArray = result else {
                
                return
            }
            for dict in resultArray {
                self.otherDestination.append(DestinationModel(dict: dict))
            }
            self.dataArray.append(self.otherDestination[0])
            self.titleArray.append(["未知的其他风景","Other"])
            self.tableView.reloadData()
            
        }
    
    dispatch_group_notify(group, dispatch_get_main_queue()) { 
        
        if self.dataArray.count == 5 {
            SVProgressHUD.dismiss()
        } else {
            SVProgressHUD.showErrorWithStatus("网络数据出错")
        }
        
        dispatch_group_leave(group)
        
        }
        
    }
}

// MARK:- ËÆæÁΩÆUI
extension HomeTableViewController {
    func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = UIView()
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 200)
        self.tableView.tableHeaderView = headerView
        
        let imageView = UIImageView(frame: headerView.bounds)
        imageView.image = UIImage(named: "bg1_375x461_")
        headerView.addSubview(imageView)
        
        let label = UILabel()
        label.textColor = kGlobelColor
        label.text = "欢迎加入Wanderer"
        //label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.sizeToFit()
        label.center = headerView.center
        headerView.addSubview(label)
        
        self.title = "首页"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.0)), forBarMetrics: .Default)
        self.tableView.rowHeight = 200
        
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.requestData()
        })
        self.tableView.backgroundColor = UIColor.getGlobeColorWithAlpha(1.0)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

// 代理与数据源
var y : CGFloat = 0.0
extension HomeTableViewController {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(scrollView.contentOffset.y / 136.0)), forBarMetrics: .Default)
        let cells = self.tableView.visibleCells as! [HomeTableViewCell]
        let offset = (scrollView.contentOffset.y - y) * (100.0 / kScreenHeight)
        for cell in cells {
            cell.imageViewTopCons.constant += offset
        }
        y = scrollView.contentOffset.y
    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "homeCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? HomeTableViewCell
            
        if  cell == nil {
            cell = HomeTableViewCell.getHomeTableViewCell()
        }
        
        cell?.model = self.dataArray[indexPath.row]
        cell?.titleArray = self.titleArray[indexPath.row]
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell =  tableView.cellForRowAtIndexPath(indexPath) as! HomeTableViewCell
        if cell.titleArray! == ["熟悉的大陆风景","China"] {
            pusVC(["熟悉的大陆风景","China"], detinations: chinaDestination)
        } else if cell.titleArray! == ["迷人的港澳台风景","HK,TW,AM"] {
            pusVC(["迷人的港澳台风景","HK,TW,AM"], detinations: tWAMXGDetination)
        } else if cell.titleArray! == ["神往的亚洲风景","Asian"] {
            pusVC(["神往的亚洲风景","Asian"], detinations: asianDestination)
        } else if cell.titleArray! == ["浪漫的欧洲风景","Europe"] {
            pusVC(["浪漫的欧洲风景","Europe"], detinations: europeDestination)
        } else if cell.titleArray! == ["未知的其他风景","Other"] {
            pusVC(["未知的其他风景","Other"], detinations: otherDestination)
        }
    }
    
    func pusVC(titleArray : [String], detinations : [DestinationModel]) {
        let pushVC = DestinationTableViewController()
        pushVC.destinations = detinations
        pushVC.titleArray = titleArray
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
}
