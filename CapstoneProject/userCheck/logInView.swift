//
//  ViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/11.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class logInView: UIViewController {
    
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logIn(_ sender: Any) {
        checkUser()
    }
    let dataManager:CoreDataManager = CoreDataManager()
    func checkUser(){
        guard let id = ID.text, let pw = Password.text as? String else {return}
        
        dataManager.checkUser(ID:id , Password:pw)
        //아이디가 존재하지 않을때
        if dataManager.idExist == false {
            let alert = UIAlertController (title: "no Id", message: "아이디가 존재하지 않습니다!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert,animated: true)
        }else if dataManager.pwCorrect == false {
            let alert = UIAlertController (title: "Password error", message: "비밀번호가 맞지 않습니다!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert,animated: true)
        }else{
            UserDefaults.standard.set(id, forKey: "id")
            UserDefaults.standard.set(pw, forKey: "password")
            // TODO: 회원 이름 저장
        }
    }
    
    
}


