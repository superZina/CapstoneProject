//
//  UserModel.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/16.
//  Copyright © 2020 이진하. All rights reserved.
//

import Foundation

struct user: Decodable {
    var name:String?
    var ID:String?
    var password:String?
    var phone:String?
    var email:String?
}

class UserModel {
    weak var delegate: Downloadable?
    let networkModel = Network()
    
    func downloadUsers(parameters:[String:Any],url:String) {
        let request = networkModel.request(parameters: parameters, url: url)
        networkModel.response(request: request) { (data) in
            let model = try! JSONDecoder().decode([user]?.self, from: data) as [user]?
            self.delegate?.didReceiveData(data: model! as [user])
        }
    }
    
}
