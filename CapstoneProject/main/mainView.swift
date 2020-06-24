//
//  mainView.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/14.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import MapKit
import UserNotifications
import Alamofire

class mainView: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate{
    var userId:String = (UserDefaults.standard.value(forKey: "id") as? String)!
    let url = "http://localhost:3000/connect_mongodb/find"
    
    @IBOutlet weak var zoomOut: UIButton!
    @IBOutlet weak var zoomIn: UIButton!
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
    
    //즐겨찾기한 버스정류장 불러오기
    var selectedIndex:[Int] = UserDefaults.standard.value(forKey: "selected") as! [Int]
    let totalBusStop:[String] = ["IT대학교", "교육대학원","학생회관","기숙사","예술대학"]
    var newSelected:[String] = []
    
    
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
        self.zoomIn.layer.cornerRadius = 12
        self.zoomOut.layer.cornerRadius = 12
        self.tabBarController?.tabBar.tintColor = .black
        self.tabBarController?.tabBarItem.image = UIImage(named: "homeIcon")
        self.tabBarItem.selectedImage = UIImage(named: "homeIcon")
    }
    var annotaions:[BusStop] = []
    
    override func viewDidLoad() {
        var message = self.userId + "님 환영합니다!"
        super.viewDidLoad()
        let alert = UIAlertController (title: "Welcome!", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (result, Error) in
            print(result)
        }
        
        mainMap.delegate = self
        //locationManagerDelegate
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //mapDelegate
        
        mainMap.mapType = MKMapType.standard
        mainMap.showsUserLocation = true
        
        
        let IT = BusStop(title: "IT대학교", coordinate: CLLocationCoordinate2D(latitude: 37.450837, longitude: 127.127502), subtitle: "IT대 정류장")
        let edu = BusStop(title: "교육대학원", coordinate: CLLocationCoordinate2D(latitude: 37.451603, longitude: 127.131018), subtitle: "교육대학원 정류장")
        let library = BusStop(title: "학생회관", coordinate: CLLocationCoordinate2D(latitude: 37.453207, longitude: 127.133751), subtitle: "학생회관 정류장")
        let student = BusStop(title: "기숙사", coordinate: CLLocationCoordinate2D(latitude:  37.453769, longitude: 127.134695), subtitle: "기숙사 정류장")
        let domitory = BusStop(title: "예술대학", coordinate: CLLocationCoordinate2D(latitude: 37.451961, longitude: 127.128809), subtitle: "예술대학 앞 정류장")
        
        myAnnotation.title = "무당이"
        annotaions = [IT,edu,library,student,domitory]
        mainMap.addAnnotation(IT)
        mainMap.addAnnotation(domitory)
        mainMap.addAnnotation(student)
        mainMap.addAnnotation(library)
        mainMap.addAnnotation(edu)
        mainMap.addAnnotation(myAnnotation)
        
        
        //즐겨찾기 정류장 업데이트
        for i in selectedIndex {
            newSelected.append(totalBusStop[i])
        }
        print(myAnnotation.coordinate)
        //알림 스레드(백그라운드)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            
            
            DispatchQueue.global(qos: .background).async {
                Alamofire
                    .request(self.url, method: .post)
                    .validate()
                    .responseJSON{ (res) in
                        guard let jsonObject = res.result.value as? NSArray else {
                            NSLog("서버 호출 과정에서 에러 발생")
                            return
                        }
                        print(jsonObject)
                        let Lat = jsonObject[0] as! NSDictionary
                        let Long = jsonObject[1] as! NSDictionary
                        guard let lat:NSNumber = Lat["value"] as! NSNumber else {0.0}
                        guard let lon:NSNumber = Long["value"] as! NSNumber else {0.0}
                        print(lat," ",lon)
//                        let doubleLat = Float(lat)
//                        let doubleLon = Double(lon)
//                        print(doubleLat ," ",doubleLon)
                        let destinationPosition = CLLocationCoordinate2D(latitude: CLLocationDegrees( truncating: lat), longitude: CLLocationDegrees( truncating: lon))
                        UIView.animate(withDuration: 4, animations: {
                            self.myAnnotation.coordinate = destinationPosition
                        })
                        
                }
                
            }
            
                        DispatchQueue.global(qos: .background).async {
                            for annotaion in self.mainMap.annotations {
                                for i in self.newSelected {
                                    if annotaion.title == i {
                                        if self.myAnnotation.coordinate.latitude != 0.0 {
                                            var distance = CLLocation(latitude: self.myAnnotation.coordinate.latitude, longitude: self.myAnnotation.coordinate.longitude).distance(from: CLLocation(latitude: annotaion.coordinate.latitude, longitude: annotaion.coordinate.latitude))
                                            print(annotaion.title)
                                            print(Int(distance))
                                            if  distance < 7687795 {
                                                let content = UNMutableNotificationContent()
                                                content.title = "버스 알리미"
                                                content.body = "버스가 곧 도착합니다 "
                                                content.badge = 1
                                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                                                let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
                                                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                            }
                                        }
                                    }
                                }
                            }
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
            
            
        })
        manager.stopUpdatingLocation()
    }
    
    let selectPopUpStoryboard = UIStoryboard(name: "popUpView", bundle: Bundle.main)
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
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
        
        
        
        
        //time을 위한 alamofire 호출
        
        Alamofire
        .request(self.url, method: .post)
        .validate()
        .responseJSON{ (res) in
            guard let jsonObject = res.result.value as? NSArray else {
                NSLog("서버 호출 과정에서 에러 발생")
                return
            }
            let Time = jsonObject[2] as! NSDictionary
            let time:String = Time["value"] as! String
            PopUp.time.text = time + "분 뒤 도착예정"
        }
        self.present(PopUp, animated: true, completion: nil)
        
        
    }
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let reuseId = "BusStop"
//
//        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//
////        if annotation.title == "무당이" {
//            anView!.image = UIImage(named: "무당이")
////        }
//
//
//        return anView
//    }
}
