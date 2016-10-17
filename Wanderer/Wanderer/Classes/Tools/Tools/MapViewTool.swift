//
//  MapViewTool.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/27.
//  Copyright © 2016年 even. All rights reserved.
//

import MapKit

//class MapViewTool: NSObject {
//    func setupMaView(_ _, model : DestinationDetailModel?, mapView : MKMapView) {
//        mapView.mapType = s.standard
//        mapView.delegate = self
//        
//        var i :Int = 0
//        for day in (model?.models1[0].days1)! {
//            var polyLineArray : [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
//            
//            for point in day.points1 {
//                let lat = point.poi?.lat?.doubleValue
//                let lng = point.poi?.lng?.doubleValue
//                //print(lat,lng)
//                
//                polyLineArray.append(CLLocationCoordinate2DMake(lat!, lng!))
//                
//                let annotation = MapViewAnnotation()
//                annotation.coordinate = CLLocationCoordinate2DMake(lat!, lng!)
//                annotation.subtitle = "\(i)"
//                mapView.addAnnotation(annotation)
//                
//                
//                if i == 0 {
//                    mapView.setCenrionCoordinate2DMake(lat!, lng!), animated: true)
//                    mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat!, lng!), MKCoordinateSpanMake(2.82042944296548, 7.8002939412587)), animated: true)
//                }
//                //print(i)
//                
//                i += 1
//            }
//            mapView.add(MKPolydrdinates: &polyLineArray, count: polyLineArray.count))
//        }
//    }
//}
//
//extension MapViewTool : MKMapViewDelegate{
//    func mapView(_ mapView: MKMa_, _: pView, viewFor annotation:ron) -> MKAnnotationView? {
//        // 自定义大头针
//        // 如果想要自定义大头针, 要不使用 MKAnnotationView, 或者是自己定义的子类
//        
//        let iden = "item"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: iden)
//(w,,       if ann: tationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: iden)
//        }
//        
//        // 非常重要的步骤
//        annotationView?.annotation = annotation
//        
//        
//        // 设置打头针的图片
//        //print((annotation.subtitle!! as NSString).integerValue)
//        annotationView?.image = UIImage.getMapPinViewWithNumber((annotation.subtitle!! as NSString).integerValue, image: UIImage(named: "map_pin_22x32_")!)
//        
//        
//        return annotationView
//    }
//    
//    func mapView(_ mapView: MKMapView,_  rendererFor, overlay: MKOverlarOverlayRenderer,, {
//        let render : MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
//        
//        render.lineWidth = 2
//        
//        render.strokeColor = UIColor.red
//        
//        return d   }
//}
