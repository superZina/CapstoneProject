//
//  presentBusStopViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/19.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import WebKit

class presentBusStopViewController: UIViewController {

    @IBOutlet weak var busWeb: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://192.168.43.219:8080/stream")
        let myRequest = URLRequest(url: url!)
        busWeb.load(myRequest)
    }
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
