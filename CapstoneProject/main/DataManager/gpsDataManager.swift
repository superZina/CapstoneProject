//
//  loginDataManager.swift
//  ios
//
//  Created by 이진하 on 2020/05/29.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import MapKit

class gpsDataManager {

    let url = "http://localhost:3000/connect_mongodb/find"
    
    func getUser(_ mainView: mainView ){
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
                let destinationPosition = CLLocationCoordinate2D(latitude: 37.4930281, longitude: 127.140036 )
                UIView.animate(withDuration: 4, animations: {
                    mainView.myAnnotation.coordinate = destinationPosition
                })
        }
        
    }
}
