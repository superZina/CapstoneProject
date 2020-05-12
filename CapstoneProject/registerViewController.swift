//
//  registerViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/12.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class registerViewController: UIViewController {
    
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
        let id = ID.text as! String
        manager.checkID(ID: id)
        if(manager.idExist == true){
            let alert = UIAlertController(title: "error", message: "이미 아이디가 존재 합니다! ", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert,animated: true)
            manager.idExist = false
            
        }else{
            let alert = UIAlertController(title: "available", message: "사용 가능한 아이디 입니다! ", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert,animated: true)
        }
        isIDChecked = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isIDChecked = false
    }
    
    var manager:CoreDataManager = CoreDataManager()
    func addUser(){
        guard let id = ID.text , let password = Password.text,let passwordCF = PasswordCF.text ,let phone = PhoneNum.text, let email = Email.text else {return}
        
        if password != passwordCF {
            let alert = UIAlertController(title: "error", message: "비밀번호를 확인해주세요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert,animated: true)
            self.Password.becomeFirstResponder()
        }else{
            
            if isIDChecked == false{
                let alert = UIAlertController(title: "error", message: "아이디 중복체크를 해주세요!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "확인", style: .cancel)
                alert.addAction(cancelAction)
                self.present(alert,animated: true)
            }else{
                manager.registUser(ID: id, Password: password, Phone: phone, Email: email)
            }
        }
    }
    
}
