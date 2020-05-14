//
//  updateUserView.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/14.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class updateUserView: UIViewController {
    let id:String = UserDefaults.standard.value(forKey: "id") as! String
    let dataManager:CoreDataManager = CoreDataManager()
    @IBOutlet weak var uesrID: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let phone:String = dataManager.getUser(ID: id)["phone"] as! String
        let email:String = dataManager.getUser(ID: id)["email"] as! String
        self.uesrID.text = id
        self.password.text = UserDefaults.standard.value(forKey: "password") as! String
        self.phone.text = phone
        self.email.text = email
    }
    
    @IBAction func updateUserInfo(_ sender: Any) {
//        guard let
//        dataManager.updateUser(ID: id, Password: password.text, phoneNum: phone, email: email)
    }
}
