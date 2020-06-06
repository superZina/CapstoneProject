//
//  mainView.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/14.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import MapKit

class mainView: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate{
    var userId:String = (UserDefaults.standard.value(forKey: "id") as? String)!
    @IBAction func editUserInfo(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    var manager = CLLocationManager()
    var myLocations: [CLLocation] = []
    
    @IBOutlet weak var mainMap: MKMapView!
    @IBOutlet weak var location: UILabel!
    
    override func viewDidLoad() {
        var message = self.userId + "님 환영합니다!"
        super.viewDidLoad()
        let alert = UIAlertController (title: "Welcome!", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
        
        //locationManagerDelegate
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //mapDelegate
        
        mainMap.mapType = MKMapType.standard
        mainMap.showsUserLocation = true
        
        setAnnotaion(lat: 37.450874, lon: 127.128890, delta: 1, title: "가천대학교", subtitle: "글로벌 캠퍼스")
    }
    @IBAction func myLocation(_ sender: Any) {
        
        manager.startUpdatingLocation()
    }
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue:CLLocationDegrees , delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mainMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotaion(lat:CLLocationDegrees, lon:CLLocationDegrees , delta span :Double , title strTitle: String, subtitle strSubTitle :String){
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = goLocation(latitudeValue: lat, longitudeValue: lon, delta: span)
        annotaion.title = strTitle
        annotaion.subtitle = strSubTitle
        mainMap.addAnnotation(annotaion)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks,error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil{
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.location.text = "현재위치  " + address
            
        })
        manager.stopUpdatingLocation()
    }
    func foLocation(lat:CLLocationDegrees,lon:CLLocationDegrees, delta span:Double) {
        let pLocation = CLLocationCoordinate2DMake(lat, lon)
        let spanValue = MKCoordinateSpan(latitudeDelta: span , longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mainMap.setRegion(pRegion, animated: true)
    }
    
  
}
