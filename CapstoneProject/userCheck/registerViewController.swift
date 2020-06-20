//
//  registerViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/12.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Alamofire

class registerViewController: UIViewController {
    let url = "http://127.0.0.1:3000/api/User"
    
    var idExist:Bool = false
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var PasswordCF: UITextField!
    @IBOutlet weak var PhoneNum: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBAction func registerBtn(_ sender: Any) {
        addUser()
        
    }
    @IBOutlet weak var register: UIButton!
    
    @IBAction func checkID(_ sender: Any) {
        let id = ID.text!
        
         let call = Alamofire.request(url, method: .get , parameters: nil)
        call.responseJSON { (res) in
            guard let jsonObject = res.result.value as? NSArray else {
                NSLog("서버 호출 과정에서 에러 발생")
                return
            }
            print(jsonObject)
            for element in jsonObject {
                let data = element as! NSDictionary
                let loginId = data["id"] as! String
                if id == loginId {
                    self.idExist = true
                }
            }
            print(self.idExist)
            if self.idExist == true {
            let alert = UIAlertController(title: "error", message: "이미 아이디가 존재 합니다! ", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (action) in
                           self.idExist = false
                       }

            alert.addAction(cancelAction)
            self.present(alert,animated: true)

            }else {
                let alert = UIAlertController(title: "success", message: "사용 가능한 아이디 입니다!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (action) in
                               self.idExist = false
                           }

                alert.addAction(cancelAction)
                self.present(alert,animated: true)
            }

        }
        print(self.idExist)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        self.register.layer.cornerRadius = 8

    }
    
//    var manager:CoreDataManager = CoreDataManager()
    func addUser(){
        guard let id = ID.text ,let pw = Password.text ,let phone = PhoneNum.text, let email = Email.text else { return}
        if ID.text == "" || Password.text == "" || PhoneNum.text == "" || Email.text == "" {
            let alert = UIAlertController(title: "error", message: "회원 정보를 입력해주세요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert,animated: true)
        }
        
        var parameters:[String:String?] = [
            "id" : id ,
            "password" : pw,
            "phone" : phone,
            "email" : email,
            "name" : "adsfasdfsd"
        ]
        let call = Alamofire.request(url, method: .post , parameters: parameters, encoding: JSONEncoding.default)
        
        call.responseJSON { (response) in
            guard let jsonObject = response.result.value as? [String:AnyObject] else {
                NSLog("서버 호출 과정에서 에러 발생")
                print(response)
                return
            }
            
            let alert = UIAlertController(title: "regist", message: "환영합니다!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancelAction)
            self.present(alert,animated: true)        }
    }
    
}
