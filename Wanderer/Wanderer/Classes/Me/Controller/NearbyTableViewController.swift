//
//  NearbyTableViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/17.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class NearbyTableViewController: UITableViewController {
    
    var dataArray : [DestinationModel] = [DestinationModel]()
    
    var userLocation : CLLocation?
    
    lazy var cllocationM : CLLocationManager = {
        let cllocationM = CLLocationManager()
        cllocationM.delegate = self
        cllocationM.requestAlwaysAuthorization()
        return cllocationM
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }


    
}

extension NearbyTableViewController : CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.userLocation = newLocation
        
        
        
        SVProgressHUD.showWithStatus("正在加载网络数据")
        SVProgressHUD.setDefaultMaskType(.Black)
        //http://q.chanyouji.com/api/v2/destinations/nearby.json?lat=30.65370908900162&lng=104.1049324775999
        NetWorkingTools.sharedInstance.requestNearbyAcitivitiesData((self.userLocation?.coordinate.latitude)!, lng: (self.userLocation?.coordinate.longitude)! ){ (result, error) in
            guard let resultDictArray = result else {
                SVProgressHUD.showErrorWithStatus("网络数据出错")
                return
            }
            for dict in resultDictArray {
                let model =  DestinationModel(dict: dict)
                self.dataArray.append(model)
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            
        }
        
        cllocationM.stopUpdatingLocation()
        
    }
    
}

extension NearbyTableViewController {
    func setupUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(1.0)), forBarMetrics: .Default)
        self.tableView.rowHeight = 120
        cllocationM.startUpdatingLocation()
        self.title = "附近新鲜事"
        self.tableView.backgroundColor = kGlobelColor
    }

}

// MARK:- 设置数据源和代理
extension NearbyTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = NearbyTableViewCell.getCellWithTableView(tableView)
        
        cell.model = self.dataArray[indexPath.row]
        
        return cell
    }
}