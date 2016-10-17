//
//  RouteDetailTableViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/27.
//  Copyright © 2016年 even. All rights reserved.
//

import MapKit

class RouteDetailTableViewController: UITableViewController {
    
    var model : DestinationDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(1.0)),forBarMetrics:.Default)
    }
    
}

extension RouteDetailTableViewController {
    func setupUI() {
        
        let mapView = MKMapView(frame: CGRectMake(0, 0, kScreenWidth, 150))
        mapView.mapType = .Standard
        mapView.delegate = self
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
                mapView.addAnnotation(annotation)
                
                
                if i == 0 {
                    mapView.setCenterCoordinate(CLLocationCoordinate2DMake(lat!, lng!), animated: true)
                    mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat!, lng!), MKCoordinateSpanMake(2.82042944296548, 7.8002939412587)), animated: true)
                }
                //print(i)
                
                i += 1
            }
            mapView.addOverlay(MKPolyline(coordinates: &polyLineArray, count: polyLineArray.count))
        }
        
        tableView.tableHeaderView = mapView
        tableView.backgroundColor = UIColor(colorLiteralRed: 250 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha: 1.0)
        tableView.estimatedSectionHeaderHeight = 300
        tableView.estimatedRowHeight = 300
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    
        tableView.separatorColor = UIColor(colorLiteralRed: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 20)
        
        
        
    }
    
    func showMapView() {
        let vc = MapViewViewController()
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RouteDetailTableViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (model?.models1[0].days1[section].headerHeight)!
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (model?.models1[0].days1.count)!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.models1[0].days1[section].points1.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = RouteDetailTableViewCell.getPointCell(tableView)
        cell.model = model?.models1[0].days1[indexPath.section].points1[indexPath.row]
        cell.indexPAth = indexPath
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (model?.models1[0].days1[indexPath.section].points1[indexPath.row].cellHeight)!
    }
    
    
}

extension RouteDetailTableViewController : MKMapViewDelegate {
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
}
