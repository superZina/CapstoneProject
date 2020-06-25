//
//  bookMarkViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/13.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class bookMarkViewController: UIViewController {

    let url = "http://localhost:3000/connect_mongodb/find"
    @IBOutlet weak var editBookBtn: UIButton!
    @IBOutlet weak var bookMarkTable: UITableView!
    var total:[String] = []
    var location:[CLLocation] = []
    var selected:[String] = []
    var selectedIndex:[Int] = []
    var busLocation:CLLocation = CLLocation()
    var selectedLocation:[CLLocation] = []
    @IBAction func editBookMark(_ sender: Any) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        total = ["IT대학교", "교육대학원","학생회관","기숙사","예술대학"]
        location = [CLLocation(latitude: 37.450963, longitude: 127.127133),CLLocation(latitude: 37.451819, longitude: 127.131554),CLLocation(latitude: 37.452466, longitude: 127.132906),CLLocation(latitude:  37.450963, longitude: 127.134065),CLLocation(latitude: 37.456154, longitude: 127.135095)]
        self.editBookBtn.layer.cornerRadius = 5
            }
    
    override func viewWillAppear(_ animated: Bool) {        self.bookMarkTable.reloadData()
        //각 정류장에 셔틀버스 도착 시간을 받아오는 함수
        busStopDataManager().getUser(self)
        
        selectedIndex = UserDefaults.standard.value(forKey: "selected") as! [Int]
        var newSelected:[String] = []
        var newSelectedLocation:[CLLocation] = []
        for i in selectedIndex {
            newSelected.append(total[i])
            newSelectedLocation.append(location[i])
        }
        selected = newSelected
        selectedLocation = newSelectedLocation
        print(selected)
        print(selectedLocation)
        let bookMarkNib = UINib(nibName: "bookMarkTableViewCell", bundle: nil)
        self.bookMarkTable.delegate = self
        self.bookMarkTable.dataSource = self
        self.bookMarkTable.register(bookMarkNib, forCellReuseIdentifier: "bookMarkCell")
        self.bookMarkTable.estimatedRowHeight = 650.0
        self.bookMarkTable.reloadData()
    }
}
//tableView
extension bookMarkViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookMarkTable.dequeueReusableCell(withIdentifier: "bookMarkCell") as? bookMarkTableViewCell else {return UITableViewCell()}
        cell.Name.text = selected[indexPath.row] + " 정류장"
        cell.Name.layer.cornerRadius = 5
        cell.location.text = selected[indexPath.row] + " 앞"
//        let expectTime = selectedLocation[indexPath.row].distance(from: busLocation)
        Alamofire.request(self.url, method: .post)
        .validate()
        .responseJSON{ (res) in
            guard let jsonObject = res.result.value as? NSArray else {
                NSLog("서버 호출 과정에서 에러 발생")
                return
            }
            let time = jsonObject[2] as! NSDictionary
            let expectTime:String = time["value"] as! String
            print(expectTime)
        cell.expectTime.text = expectTime + "분뒤 도착 예정"
        }
        
        
        return cell
    }
    
    
}
