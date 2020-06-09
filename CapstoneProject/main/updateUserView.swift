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
//        let pw:String = dataManager.getUser(ID: id)["password"] as! String
//        let phone:String = dataManager.getUser(ID: id)["phone"] as! String
//        let email:String = dataManager.getUser(ID: id)["email"] as! String
//        self.uesrID.text = id
//        self.password.text = UserDefaults.standard.value(forKey: "password") as! String
//        self.password.text = pw
//        self.phone.text = phone
//        self.email.text = email
    }
    
    @IBAction func updateUserInfo(_ sender: Any) {
        guard let phone:String = phone.text , let email:String = email.text, let pw:String = password.text else {return}
        dataManager.updateUser(ID: id, Password: pw, phoneNum: phone, email: email)
        print("update success")
    }
}
