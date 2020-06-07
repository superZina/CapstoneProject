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
    //회원정보 수정
    @IBAction func editUserInfo(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    //지도 확대, 축소 버튼
    @IBAction func zoomMap(_ sender: Any) {
        var region: MKCoordinateRegion = mainMap.region
        region.span.latitudeDelta /= 2.0
        region.span.longitudeDelta /= 2.0
        mainMap.setRegion(region, animated: true)
    }
    @IBAction func aoomOutMap(_ sender: Any) {
        var region: MKCoordinateRegion = mainMap.region
        region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
        region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
        mainMap.setRegion(region, animated: true)
    }
    
    
    
    
    @IBOutlet weak var mainMap: MKMapView!
    @IBOutlet weak var location: UILabel!
    var manager = CLLocationManager()
    var myLocations: [CLLocation] = []
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
        
        //메인뷰에 특정 위치 표시하기(정류소 위치 표시하기)
        setAnnotaion(lat: 37.450874, lon: 127.128890, delta: 1, title: "가천대학교", subtitle: "글로벌 캠퍼스")
        setAnnotaion(lat: 37.450963, lon: 127.127133, delta: 1, title: "IT대학교", subtitle: "IT대 정류장")
        setAnnotaion(lat: 37.451819, lon: 127.131554, delta: 1, title: "교육대학원", subtitle: "교육대학원앞 정류장")
        setAnnotaion(lat: 37.452466, lon: 127.132906, delta: 1, title: "중앙도서관", subtitle: "중앙도서관 정류장")
        setAnnotaion(lat: 37.453352, lon: 127.134065, delta: 1, title: "학생회관", subtitle: "학생회관 정류장")
        setAnnotaion(lat: 37.456154, lon:  127.135095, delta: 1, title: "기숙사", subtitle: "기숙사 앞 정류장")
    
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
    //지도에 특정 위치 표시
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
    
  
}
