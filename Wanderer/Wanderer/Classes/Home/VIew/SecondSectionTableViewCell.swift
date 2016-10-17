//
//  SecondSectionTableViewCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/24.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import MapKit


class SecondSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bottomBtn: UIButton!
    
    @IBAction func showRoute(sender: UIButton) {
      NSNotificationCenter.defaultCenter().postNotificationName(kShowRouteDetailBottonClick, object: model)
    }
    var model : DestinationDetailModel? {
        didSet{
            titleLabel.text = model!.title
            
//            MapViewTool().setupMaView(model, mapView: mapView)
            mapView.mapType = .Standard
            mapView.delegate = self
            
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
                    annotation.subtitle = "\(i + 1)"
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

            
            if model?.cellHeight == 0 {
                model?.cellHeight = 210
            }
            
        }
    }
    
    class func getCellWithTableView(tableview: UITableView) ->SecondSectionTableViewCell {
        var cell = tableview.dequeueReusableCellWithIdentifier("second") as? SecondSectionTableViewCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("SecondSectionTableViewCell", owner: nil, options: nil)?.last as? SecondSectionTableViewCell
        }
        
        return cell!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension SecondSectionTableViewCell : MKMapViewDelegate {

    
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
