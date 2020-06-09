//
//  poppUpView.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class popUpView: UIViewController{
    var name:String = ""
    var dis :Double = 0
    var Time = ""
    @IBOutlet weak var busStopName: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    override func viewDidLoad() {
        busStopName.text = name
        distance.text = String(Int(dis))+"m"
        super.viewDidLoad()
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
