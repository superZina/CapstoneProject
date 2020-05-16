//
//  UserModel.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/16.
//  Copyright © 2020 이진하. All rights reserved.
//

import Foundation

class UserModel:NSObject {
    var name:String?
    var ID:String?
    var password:String?
    var phone:String?
    var email:String?
    
    override init() {
    }

    init(ID:String, name:String,password:String, phone:String,email:String){
        self.ID  = ID
        self.name = name
        self.password = password
        self.phone = phone
        self.email = email
    }
    override var description: String{
        return "ID: \(ID) , Name: \(name) , Password: \(password) , Phone: \(phone) , Email: \(email)"
    }

}
