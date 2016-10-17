import UIKit
import SVProgressHUD
import CoreLocation
class PlansTableViewController: UITableViewController {
    
    var destinations : [DestinationModel] = [DestinationModel]()
    
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
        
        reuqestData()
    }
    
    
    
    
}

// MARK:- 代理与数据源
var y3 : CGFloat = -64
extension PlansTableViewController {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(1 - offsetY / 64.0)), forBarMetrics: .Default)
        
        let cells = self.tableView.visibleCells as! [HomeTableViewCell]
        for cell in cells {
            let offsetY = (scrollView.contentOffset.y - y3) * (100 / (kScreenHeight + 200))
            cell.imageViewTopCons.constant += offsetY
        }
        y3 = scrollView.contentOffset.y
        
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

extension PlansTableViewController : CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.userLocation = newLocation
        
        
        
        SVProgressHUD.showWithStatus("正在加载网络数据")
        SVProgressHUD.setDefaultMaskType(.Black)
            //http://q.chanyouji.com/api/v2/destinations/nearby.json?lat=30.65370908900162&lng=104.1049324775999
        NetWorkingTools.sharedInstance.requestNearbyData((self.userLocation?.coordinate.latitude)!, lng: (self.userLocation?.coordinate.longitude)! ){ (result, error) in
            guard let resultDictArray = result else {
                SVProgressHUD.showErrorWithStatus("网络数据出错")
                return
            }
            for dict in resultDictArray {
                let model =  DestinationModel(dict: dict)
                self.destinations.append(model)
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            
        }
        
        cllocationM.stopUpdatingLocation()
        
    }

}


// MARK:- 设置UI
extension PlansTableViewController {
    func setupUI() {
        self.title = "附近目的地"
        tableView.rowHeight = 200
        //self.navigationController?.navigationBar.backgroundColor = kGlobelColor
        self.tableView.backgroundColor = UIColor.getGlobeColorWithAlpha(1.0)
        self.navigationController?.navigationBar.backgroundColor = UIColor.getGlobeColorWithAlpha(0.00001)
        cllocationM.startUpdatingLocation()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func reuqestData() {
        
    }

}