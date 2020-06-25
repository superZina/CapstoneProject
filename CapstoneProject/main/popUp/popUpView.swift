//
//  poppUpView.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Alamofire

class popUpView: UIViewController{
    let url = "http://localhost:3000/connect_mongodb/find"

    var name:String = ""
    var dis :Double = 0
    var Time = ""
    @IBOutlet weak var refresh: UIButton!
    @IBOutlet weak var busStopName: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    override func viewDidLoad() {
        busStopName.text = name
        distance.text = String(Int(dis))+"m"
        super.viewDidLoad()
    }
    @IBAction func refreshTime(_ sender: Any) {
        Alamofire
        .request(self.url, method: .post)
        .validate()
        .responseJSON{ (res) in
            guard let jsonObject = res.result.value as? NSArray else {
                NSLog("서버 호출 과정에서 에러 발생")
                return
            }
            let Time = jsonObject[2] as! NSDictionary
            let time:Double = Time["value"] as! Double// 전체 시간값
            let min:Int = Int(time) //분
            let sec:Double = (time -  Double(min)) * 0.6 * 100 //초
            let message:String
            if sec < 10.0 && min == 0{
                message = "곧 도착"
            }else{
              message = String(min)+" 분"+String(Int(sec))+" 초 뒤 도착 예정"
            }
            self.time.text = message
        }
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
