//
//  busStopDataManager.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/15.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import MapKit

class busStopDataManager {

    let url = "http://localhost:3000/connect_mongodb/find"
    
    func getUser(_ mainView: bookMarkViewController ){
        Alamofire
            .request(url, method: .post)
            .validate()
            .responseJSON { (res) in
                guard let jsonObject = res.result.value as? NSArray else {
                    NSLog("서버 호출 과정에서 에러 발생")
                    return
                }
                print(jsonObject)
                let Lat = jsonObject[0] as! NSDictionary
                let Long = jsonObject[1] as! NSDictionary
                print(Lat["value"])
                print(Long["value"])
//                let lat = Lat["value"]
//                let lon = Long["value"] as! Double
                let destinationPosition = CLLocation(latitude: 37.4930281, longitude: 127.140036 )
                    
                mainView.busLocation = destinationPosition
        }
        
    }
}
