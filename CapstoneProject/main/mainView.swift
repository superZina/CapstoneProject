//
//  mainView.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/14.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class mainView: UIViewController {
    var userId:String = UserDefaults.standard.value(forKey: "id") as! String
    @IBAction func editUserInfo(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: nil)
    }
    override func viewDidLoad() {
        var message = self.userId + "님 환영합니다!"
        super.viewDidLoad()
        let alert = UIAlertController (title: "Welcome!", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style
            : .cancel)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
        
    }
    
    
}
