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
    
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var PasswordCF: UITextField!
    @IBOutlet weak var PhoneNum: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBAction func registerBtn(_ sender: Any) {
        addUser()
        let alert = UIAlertController(title: "regist", message: "환영합니다!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    var isIDChecked:Bool = false
    
    @IBAction func checkID(_ sender: Any) {
//        let id = ID.text as! String
//        manager.checkID(ID: id)
//        if(manager.idExist == true){
//            let alert = UIAlertController(title: "error", message: "이미 아이디가 존재 합니다! ", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
//            alert.addAction(cancelAction)
//            self.present(alert,animated: true)
//            manager.idExist = false
//
//        }else{
//            let alert = UIAlertController (title: "available", message: "사용 가능한 아이디 입니다! ", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
//            alert.addAction(cancelAction)
//            self.present(alert,animated: true)
//        }
//        isIDChecked = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isIDChecked = false
//        manager.idExist = false
    }
    
//    var manager:CoreDataManager = CoreDataManager()
    func addUser(){
        guard let id = ID.text ,let pw = Password.text ,let phone = PhoneNum.text, let email = Email.text else {return}
        
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
            
            let alert = UIAlertController(title: "환영합니다!", message: "회원가입에 성공하였습니다!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
}
