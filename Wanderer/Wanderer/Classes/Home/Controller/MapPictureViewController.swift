//
//  MapPictureViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/16.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
class MapPictureViewController: UIViewController {
    

    var models : [DestinationModel] = [DestinationModel]()
    
    var collectionView : UICollectionView = {
        let layout = FlowLayout()
        layout.itemSize = CGSizeMake(160, 160)
        
        layout.scrollDirection = .Horizontal
        let margin = (kScreenWidth - 160) * 0.5;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        // 设置最小行间距
        layout.minimumLineSpacing = 50;
        
        let collectionView = UICollectionView(frame: CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.brownColor()
        
        
        return collectionView
    }()
    
    var timer : NSTimer?
    var j : Int = 0
    var annotationView : MKAnnotationView?
    
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.getGlobeColorWithAlpha(0.0)), forBarMetrics: .Default)
    }
    
    

}

extension MapPictureViewController {
    func setupUI() {
        let btn = UIButton(type: .Custom)
        btn.setBackgroundImage(UIImage(named: "button_back_32x32_@1x"), forState: .Normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(MapPictureViewController.popVC), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        mapView.mapType = .Standard
        mapView.delegate = self
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib(nibName: "photoCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        
        
        var i : Int = 0
        for model in models {
            let lat = model.lat?.doubleValue
            let lng = model.lng?.doubleValue
            
            
    
    
        let annotation = MapViewAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(lat!, lng!)
        annotation.subtitle = "\(i)"
        annotation.title = model.name
        self.mapView.addAnnotation(annotation)

            
            
        if i == 0 {
            mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat!, lng!),MKCoordinateSpanMake(44.3285320763786, 29.3442605293731)), animated: true)
            mapView.setCenterCoordinate(CLLocationCoordinate2DMake(lat!, lng!), animated: true)
            
        }
        i += 1
        }

    }
    
    func popVC() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    }

extension MapPictureViewController : MKMapViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegate{
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
        annotationView?.canShowCallout = true
        
        // 设置打头针的图片
        //print((annotation.subtitle!! as NSString).integerValue)
        
        annotationView?.image = UIImage(named: "map_pin_22x32_")
        
        return annotationView
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! photoCell
        cell.model = models[indexPath.row]
        return cell
    }
    
  
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if self.annotationView != nil {
            annotationView?.image = UIImage(named: "map_pin_22x32_")
        }
        
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake((view.annotation?.coordinate.latitude)!, (view.annotation?.coordinate.longitude)!),MKCoordinateSpanMake(126.38061407747, 102.206914547311)), animated: true)
        mapView.setCenterCoordinate(CLLocationCoordinate2DMake((view.annotation?.coordinate.latitude)!, (view.annotation?.coordinate.longitude)!), animated: true)
        
        view.image = UIImage(named: "map_pin_selected")
        
        self.annotationView = view
        
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: (view.annotation!.subtitle!! as NSString).integerValue, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: true)
    }
    

    
    
}
