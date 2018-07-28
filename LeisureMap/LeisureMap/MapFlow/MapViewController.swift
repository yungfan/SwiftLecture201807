//
//  MapViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var flag:MapFlag?
    
    //观察范围
    let regionRadius: CLLocationDistance = 1000
    
    //定位管理器
    lazy var locationManager: CLLocationManager = {
        
        var locationManager = CLLocationManager()
   
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        return locationManager
        
    }()
    
    
    //MARK: - UIViewController LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map"
        
        self.mapView.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() {
            
            self.locationManager.startUpdatingLocation()
        }
        
        
    }
    
    // 切换地图的视角
    func centerMapOnLocation (location:CLLocation) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: self.regionRadius, longitudinalMeters: self.regionRadius)
        
        self.mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    @objc func moveToWebView(_ sender: Any){
        
        self.performSegue(withIdentifier: "moveToNoteViewSegue", sender: self)
    }
    
    func addFlag() {
        
        
        let gcjLat =   LocationTransform.wgs2gcj(wgsLat: 31.2916511800, wgsLng: 118.3623587000).gcjLat
        let gcjLng =   LocationTransform.wgs2gcj(wgsLat: 31.2916511800, wgsLng: 118.3623587000).gcjLng
    
        flag = MapFlag(title: "iOS App by Swift", locationName: "商贸学院", discipline: "好学校", coordinate: CLLocationCoordinate2DMake(gcjLat,gcjLng), url: "https://www.baidu.com")
    
        self.mapView.addAnnotation(flag!)
       
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //通过segue的identifier判断到底是跳转的哪根线
        switch segue.identifier {
            
        case "moveToNoteViewSegue":
            
            let noteViewController = segue.destination as! NoteViewController
            
            noteViewController.urlString = self.flag?.urlString
            
        default:
            
            print("error")
        }
        
    }

}


extension MapViewController: MKMapViewDelegate{
    
    //对于国内地图而言，使用LocationManager定位所获得经纬度，是有一段较大距离的偏移的。
    //解决方法一：想要获得自己准确的经纬度可以直接通过MKMapView中对自身定位来获得，就是下面的方法
    //解决方法二：自己转换坐标系
    
    //国内地图使用的坐标系统是GCJ-02而ios sdk中所用到的是国际标准的坐标系统WGS-84。因为国内使用的是加密后的坐标系GCJ-02就是网络上叫的火星坐标。
    //locationManager就是因为得到的是火星坐标偏移后的经纬度，所以导致在MapView上有很大的偏差，而在MKMapView上通过定位自己位置所获得的经纬度有是准确，因为apple已经对国内地图做了偏移优化。
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        
//        guard let location = userLocation.location  else{
//
//            return
//        }
//
//        self.centerMapOnLocation(location: location)
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? MapFlag  else{
            
            return nil
        }

        //大头针的标识符
        let identifier = "marker"
        //大头针视图
        let annotationView :MKAnnotationView
        
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)  as? MKMarkerAnnotationView {
            
            dequeueView.annotation = annotation
            
            annotationView = dequeueView
            
        }
        else{
            
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView.canShowCallout = true
            
            annotationView.calloutOffset = CGPoint(x: -5.0, y: 5.0)
            
            let button = UIButton(type: .detailDisclosure)
            
            button.addTarget(self, action: #selector(moveToWebView), for: .touchUpInside)
            
            annotationView.rightCalloutAccessoryView = button
            
        }


        return annotationView

    }
    
}

extension MapViewController: CLLocationManagerDelegate{
    
    //定位成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = manager.location  else{
            
            return
        }
 
        //火星坐标
        //self.centerMapOnLocation(location: location)
 
        
        //自己切换到WGS-84坐标系  效果与方法一一样
       let gcjLat =   LocationTransform.wgs2gcj(wgsLat: location.coordinate.latitude, wgsLng: location.coordinate.longitude).gcjLat
       let gcjLng =   LocationTransform.wgs2gcj(wgsLat: location.coordinate.latitude, wgsLng: location.coordinate.longitude).gcjLng

       let newLocation:CLLocation = CLLocation(latitude: gcjLat, longitude: gcjLng)

       self.centerMapOnLocation(location: newLocation)
    
       self.addFlag()
        
       self.locationManager.stopUpdatingLocation()
        
    }
    
    //定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        
    }
    
    
}
