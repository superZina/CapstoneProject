//
//  updateUserView.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/14.
//  Copyright © 2020 이진하. All rights reserved.
//
import UserNotifications
import UIKit
import Alamofire

class updateUserView: UIViewController, UNUserNotificationCenterDelegate {
    let id:String = UserDefaults.standard.value(forKey: "id") as! String
    let token:String = UserDefaults.standard.value(forKey: "token") as! String
    @IBOutlet weak var uesrID: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        let id:String = UserDefaults.standard.value(forKey: "id") as! String
        let password:String = UserDefaults.standard.value(forKey: "password") as! String
        let email:String = UserDefaults.standard.value(forKey: "email") as! String
        let phone:String = UserDefaults.standard.value(forKey: "phone") as! String
        let name:String = UserDefaults.standard.value(forKey: "name") as! String
        self.uesrID.text = id
        self.password.text = password
        self.phone.text = phone
        self.name.text = name
        self.email.text = email
        self.deleteBtn.layer.cornerRadius = 5
        self.logouBtn.layer.cornerRadius = 5
        self.updateBtn.layer.cornerRadius = 5
    }
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var logouBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    @IBAction func updateUserInfo(_ sender: Any) {
        let url = "http://127.0.0.1:3000/api/User/\(self.token)"
        guard let phone:String = phone.text , let email:String = email.text, let pw:String = password.text, let name:String = name.text else {return}
        
        let parameters:[String:String?] = [
            "password" : pw,
            "phone" : phone,
            "email" : email,
            "name" : name
        ]
        let call = Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
        call.responseJSON { (response) in
            print(response)
        }
        print("update success")
        let alert = UIAlertController(title: "update success", message: "회원정보 수정 완료!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "email")
        let alert = UIAlertController(title: "logout sucess", message: "로그아웃 완료!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) {  UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        self.present(alert,animated: true,completion: nil)

        
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        let url = "http://127.0.0.1:3000/api/User/\(self.token)"
        _ = Alamofire.request(url, method: .delete)
        let alert = UIAlertController(title: "delete success", message: "회원탈퇴 완료!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) {  UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        self.present(alert,animated: true,completion: nil)
    }
}
