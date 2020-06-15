//
//  forgetIdPwViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/15.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Alamofire

class forgetIdPwViewController: UIViewController {
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var pwName: UITextField!
    @IBOutlet weak var Id: UITextField!
    let url =  "http://127.0.0.1:3000/api/User"
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func whatIsMyPw(_ sender: Any) {
        guard let id = Id.text ,let name = pwName.text , let phone = phone.text else {return}
        let call = Alamofire.request(url, method: .get , parameters: nil)
        call.responseJSON { (res) in
            guard let jsonObject = res.result.value as? NSArray else {
                NSLog("서버 호출 과정에서 에러 발생")
                return
            }
            for element in jsonObject{
                let data = element as! NSDictionary
                let ID = data["id"] as! String
                let Name = data["name"] as! String
                let Phone = data["phone"] as! String
                if ID == id {
                    if Name == name {
                        if Phone == phone {
                            let PW = data["password"] as! String
                            let message:String = "비밀번호 : " + PW
                            let alert = UIAlertController (title: "password", message: message, preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
                            alert.addAction(cancelAction)
                            self.present(alert,animated: true)
                        }
                    }
                }
            }
            
        }
    }
    @IBAction func WhatIsMyID(_ sender: Any) {
        guard let name = name.text ,let email = email.text else {return}
        let call = Alamofire.request(url, method: .get , parameters: nil)
        call.responseJSON { (res) in
            guard let jsonObject = res.result.value as? NSArray else {
                NSLog("서버 호출 과정에서 에러 발생")
                return
            }
            for element in jsonObject{
                let data = element as! NSDictionary
                let Email = data["email"] as! String
                let Name = data["name"] as! String
                
                if Email == email {
                    if Name == name {
                        let ID = data["id"] as! String
                        let message:String = "id : " + ID
                        let alert = UIAlertController (title: "id", message: message, preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
                        alert.addAction(cancelAction)
                        self.present(alert,animated: true)
                    }
                }else {
                    let alert = UIAlertController (title: "error", message: "일치하는 회원정보 없음!", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "확인", style: .cancel)
                    alert.addAction(cancelAction)
                    self.present(alert,animated: true)
                }
            }
        }
        
        
        
    }
}
