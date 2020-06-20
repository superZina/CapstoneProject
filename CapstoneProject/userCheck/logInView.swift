//
//  ViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/11.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON
import ObjectMapper

struct user {
    var id:String
    var pw:String
    var phone:String
    var email:String
    init(id:String,pw:String,phone:String,email:String){
        self.id = id
        self.pw = pw
        self.phone = phone
        self.email = email
    }
}
class logInView: UIViewController {
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    var userList:[user] = []
    
    let url = "http://127.0.0.1:3000/api/User"
    
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.registerBtn.layer.cornerRadius = 8
        self.navigationController?.navigationBar.tintColor = .black
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ID.delegate = self
        self.Password.delegate = self
        self.logInBtn.layer.cornerRadius = 8
        
    }
    
    @IBAction func logIn(_ sender: Any) {
        checkUser()
    }
    
    func checkUser(){
        guard let id = ID.text ,let pw = Password.text else {return}
        let call = Alamofire.request(url, method: .get , parameters: nil)
        
        call.responseJSON { (res) in
            guard let jsonObject = res.result.value as? NSArray else {
                NSLog("서버 호출 과정에서 에러 발생")
                return
            }
            self.userList.removeAll()
            print(jsonObject)
            for element in jsonObject{ // jsonArray들 하나하나 검사
                
                let data = element as! NSDictionary
                let loginId = data["id"] as! String
                let loginPw = data["password"] as! String
                print(loginId)
                print(loginPw)
                if(id == loginId){
                    //비밀번호가 틀릴 때
                    if(pw != loginPw ){
                        let alert = UIAlertController (title: "Password error", message: "비밀번호가 맞지 않습니다!", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
                        alert.addAction(cancelAction)
                        self.present(alert,animated: true)
                    }else{
                        // 아이디 존재, 비밀번호 일치
                        let token = data["_id"] as! String
                        let email = data["email"] as! String
                        let name = data["name"] as! String
                        let phone = data["phone"] as! String
                        UserDefaults.standard.set(id, forKey: "id")
                        UserDefaults.standard.set(pw, forKey: "password")
                        UserDefaults.standard.set(token, forKey: "token")
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(name, forKey: "name")
                        UserDefaults.standard.set(phone, forKey: "phone")
                        let tab = self.storyboard?.instantiateViewController(withIdentifier: "tabView") as! UITabBarController
                        self.navigationController?.pushViewController(tab, animated: true)
                        break
                    }
                }
                
            }
        }

    }
    
    
}

extension logInView: UITextFieldDelegate {
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n"){
            textField.resignFirstResponder()
        }
        return true
    }
}
