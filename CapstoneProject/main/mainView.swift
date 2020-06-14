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
    
    
    @IBAction func updateLocation(_ sender: Any) {
        gpsDataManager().getUser(self)
//        })
    }
    
    
    @IBOutlet weak var mainMap: MKMapView!
    @IBOutlet weak var location: UILabel!
    var manager = CLLocationManager()
    var myLocations: [CLLocation] = []
    let myAnnotation = MKPointAnnotation()
    var lat = 37.450114
    var lon = 127.140036
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isTranslucent = false
//        gpsDataManager().getUser(self)
    }
    var annotaions:[BusStop] = []
    
    override func viewDidLoad() {
        var message = self.userId + "님 환영합니다!"
        super.viewDidLoad()
        let alert = UIAlertController (title: "Welcome!", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
        
        mainMap.delegate = self
        //locationManagerDelegate
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //mapDelegate
        
        mainMap.mapType = MKMapType.standard
        mainMap.showsUserLocation = true
        
        //메인뷰에 특정 위치 표시하기(정류소 위치 표시하기)
//        setAnnotaion(lat: lat, lon: lon, delta: 1, title: "가천대학교", subtitle: "글로벌 캠퍼스")
        
        let IT = BusStop(title: "IT대학교", coordinate: CLLocationCoordinate2D(latitude: 37.450963, longitude: 127.127133), subtitle: "IT대 정류장")
        let edu = BusStop(title: "교육대학원", coordinate: CLLocationCoordinate2D(latitude: 37.451819, longitude: 127.131554), subtitle: "교육대학원 정류장")
        let library = BusStop(title: "중앙도서관", coordinate: CLLocationCoordinate2D(latitude: 37.452466, longitude: 127.132906), subtitle: "중앙도서관 정류장")
        let student = BusStop(title: "학생회관", coordinate: CLLocationCoordinate2D(latitude:  37.450963, longitude: 127.134065), subtitle: "학생회관 정류장")
        let domitory = BusStop(title: "기숙사", coordinate: CLLocationCoordinate2D(latitude: 37.456154, longitude: 127.135095), subtitle: "기숙사 앞 정류장")

        let startPostion = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        annotaions = [IT,edu,library,student,domitory]
        mainMap.addAnnotation(IT)
        mainMap.addAnnotation(domitory)
        mainMap.addAnnotation(student)
        mainMap.addAnnotation(library)
        mainMap.addAnnotation(edu)
        mainMap.addAnnotation(myAnnotation)
    }
    
    
    
    
    @IBAction func myLocation(_ sender: Any) {
        let title = "IT대학교"
//        manager.startUpdatingLocation()
        for annotation in self.mainMap.annotations {
            if annotation.title == title{
                self.mainMap.selectAnnotation(annotation, animated: true)
            }
        }
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
        let selectPopUpStoryboard = UIStoryboard(name: "popUpView", bundle: Bundle.main)
        guard let PopUp = selectPopUpStoryboard
            .instantiateViewController(withIdentifier: "popUpView") as? popUpView else {
                return
        }
        PopUp.modalPresentationStyle = .custom
        guard let busStopName = view.annotation?.title else {return}
        PopUp.name = busStopName!
        let preLat = (view.annotation?.coordinate.latitude)!
        let preLon = (view.annotation?.coordinate.longitude)!
        let preLoc = CLLocation(latitude: preLat, longitude: preLon)
        let userLoc = CLLocation(latitude: (self.manager.location?.coordinate.latitude)!, longitude: (self.manager.location?.coordinate.longitude)!)
        PopUp.dis = preLoc.distance(from: userLoc)
        
        goLocation(latitudeValue: preLat, longitudeValue: preLon, delta: 0.01)
        self.present(PopUp, animated: true, completion: nil)
    }
  
}
