//
//  MapViewViewController.swift
//  Wanderer
//
//  Created by ÂàòÊù∞ on 16/9/27.
//  Copyright ¬© 2016Âπ¥ even. All rights reserved.
//

import MapKit
import SVProgressHUD

class MapViewViewController: UIViewController {

    var model : DestinationDetailModel?
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    var userLocation : CLLocation?
    var isNav : Bool = false
    
    lazy var cllocationM : CLLocationManager = {
        let cllocationM = CLLocationManager()
        cllocationM.delegate = self
        cllocationM.requestAlwaysAuthorization()
        return cllocationM
    }()
    
    lazy var geoCoder : CLGeocoder = {
        let geoCoder = CLGeocoder()
        return geoCoder
    }()
    
    var annotationView : MKAnnotationView?
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.0)), forBarMetrics: .Default)
        }
    
    deinit {
    
        SVProgressHUD.dismiss()
    }
}
// MARK:- 设置UI
extension MapViewViewController {
    func setupUI() {
        cllocationM.startUpdatingLocation()
        let btn = UIButton(type: .Custom)
        btn.setBackgroundImage(UIImage(named: "button_back_32x32_@1x"), forState: .Normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(MapViewViewController.popVC), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        mapView.mapType = .Standard
        let tap = UITapGestureRecognizer(target: self, action: #selector(RouteDetailTableViewController.showMapView))
        mapView.addGestureRecognizer(tap)
        
        var i :Int = 0
        for day in (model?.models1[0].days1)! {
            var polyLineArray : [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
            
            for point in day.points1 {
                let lat = point.poi?.lat?.doubleValue
                let lng = point.poi?.lng?.doubleValue
                //print(lat,lng)
                
                polyLineArray.append(CLLocationCoordinate2DMake(lat!, lng!))
                
                let annotation = MapViewAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(lat!, lng!)
                annotation.subtitle = "\(i)"
                annotation.title = point.poi?.name
                mapView.addAnnotation(annotation)
                
                
                if i == 0 {
                    mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat!, lng!),MKCoordinateSpanMake(2.82042944296548, 7.8002939412587)), animated: true)
                    mapView.setCenterCoordinate(CLLocationCoordinate2DMake(lat!, lng!), animated: true)
                    
                }
                //print(i)
                
                i += 1
            }
            mapView.addOverlay(MKPolyline(coordinates: &polyLineArray, count: polyLineArray.count))
        }
        
        CollectionView.registerNib(UINib(nibName: "PointCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pCell")
        let layout = CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        cllocationM.startUpdatingLocation()

    }
    
    func popVC() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}


extension MapViewViewController : MKMapViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // 自定义大头针
        // 如果想要自定义大头针, 要不使用 MKAnnotationView, 或者是自己定义的子类
        
        let iden = "item"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(iden)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: iden)
        }
        
        // 非常重要的步骤
        annotationView?.annotation = annotation
        
        
        // 设置打头针的图片
        //print((annotation.subtitle!! as NSString).integerValue)
        annotationView?.image = UIImage.getMapPinViewWithNumber((annotation.subtitle!! as NSString).integerValue, image: UIImage(named: "map_pin_22x32_")!)
        
        
        return annotationView
    }
    
    func mapView(rw: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render : MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        render.lineWidth = 2
        
        render.strokeColor = UIColor.redColor()
        
        return render
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.models1[0].days1[section].points1.count)!
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return  (model?.models1[0].days1.count)!
    }
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = CollectionView.dequeueReusableCellWithReuseIdentifier("pCell", forIndexPath: indexPath) as! PointCollectionViewCell
        cell.num = i
        let poi = model?.models1[0].days1[indexPath.section].points1[indexPath.row].poi
        cell.model = poi?.name
        
        i += 1
        return cell
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.userLocation = newLocation
        if isNav == true {
            startNav(self.annotationView!)
            isNav = false
        }
    }
    

    func startNav(annotationView : MKAnnotationView) {
        
        // CLLocation(latitude: 30.67, longitude: 104.06)
        if self.userLocation == nil {
            SVProgressHUD.setDefaultMaskType(.Black)
            SVProgressHUD.showWithStatus("正在获取您当前的位置，请稍等")
            return
        }
        SVProgressHUD.showWithStatus("正在打开地图")
        geoCoder.reverseGeocodeLocation(self.userLocation!) { (CLPls, error) in
            if error == nil {
                let userPL = CLPls?.first
                self.geoCoder.geocodeAddressString(((annotationView.annotation?.title)!)!, completionHandler: { (endCLPLs, error) in
                    if error == nil {
                        let endPL = endCLPLs?.first
                        
                        let startItem : MKMapItem = MKMapItem(placemark: MKPlacemark(placemark: userPL!))
                        let endItem : MKMapItem = MKMapItem(placemark: MKPlacemark(placemark: endPL!))
                        
                        let mapItems : [MKMapItem] = [startItem,endItem]
                        
                        let dic: [String : AnyObject] = [
                            // 设置导航模式
                            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving as AnyObject,
                            // 设置地图类型
                            MKLaunchOptionsMapTypeKey: MKMapType.Standard.rawValue as AnyObject,
                            //  设置交通状况
                            MKLaunchOptionsShowsTrafficKey: true as AnyObject
                            
                        ]
                        
                        MKMapItem.openMapsWithItems(mapItems, launchOptions: dic)

                    }
                })
                SVProgressHUD.dismiss()
            } else {
                print(error)
                SVProgressHUD.setDefaultMaskType(.Clear)
                SVProgressHUD.showErrorWithStatus("导航出现错误")
            }
        }
    }
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if self.annotationView != nil {
            annotationView?.image = UIImage.getMapPinViewWithNumber((view.annotation!.subtitle!! as NSString).integerValue, image: UIImage(named: "map_pin_22x32_@1x")!)
        }
        view.image = UIImage.getMapPinViewWithNumber((view.annotation!.subtitle!! as NSString).integerValue, image: UIImage(named: "map_pin_selected")!)
        
        mapView.setCenterCoordinate(CLLocationCoordinate2DMake(view.annotation!.coordinate.latitude, view.annotation!.coordinate.longitude), animated: true)
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(view.annotation!.coordinate.latitude, view.annotation!.coordinate.longitude), MKCoordinateSpanMake(0.0472872817399654, 0.0321865112188675)), animated: true)
    
        if self.annotationView == view{
            let ac = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            ac.addAction(UIAlertAction(title: "苹果地图导航", style: .Default, handler:{ (complete) in
                
                // 开始导航
                self.isNav = true
                self.startNav(self.annotationView!)
                
            }))
            ac.addAction(UIAlertAction(title: "取消", style: .Cancel, handler:{ (action) in
                
            }))
            
            self.presentViewController(ac, animated: true, completion: nil)
        }
        
        self.annotationView = view
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poi = model?.models1[0].days1[indexPath.section].points1[indexPath.row].poi
        
        mapView.setCenterCoordinate(CLLocationCoordinate2DMake((poi?.lat!.doubleValue)!, (poi?.lng!.doubleValue)!), animated: true)
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake((poi?.lat!.doubleValue)!, (poi?.lng!.doubleValue)!), MKCoordinateSpanMake(0.0472872817399654, 0.0321865112188675)), animated: true)
        
        
        for annotation in mapView.annotations {
            mapView.deselectAnnotation(annotation, animated: true)
        }
        
        for annotation in mapView.annotations {
            if annotation.coordinate.latitude == poi?.lat!.doubleValue && annotation.coordinate.longitude == (poi?.lng!.doubleValue)!
            {
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }

    }
    
}
