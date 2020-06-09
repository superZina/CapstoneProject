//
//  busStopListViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class busStopListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var busStop:[String] = ["IT대학교","교육대학원","중앙도서관","학생회관","기숙사"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        busStop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = busStopTable.dequeueReusableCell(withIdentifier: "busStopCell") as? busStopTableViewCell else {return UITableViewCell()}
        cell.busStopName.setTitle(busStop[indexPath.row], for: .normal) 
        return cell
    }
    

    @IBOutlet weak var busStopTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let busNib = UINib(nibName: "busStopTableViewCell", bundle: nil)
        self.busStopTable.delegate = self
        self.busStopTable.dataSource = self
        self.busStopTable.register(busNib, forCellReuseIdentifier: "busStopCell")
        self.busStopTable.estimatedRowHeight = 550.0
        // Do any additional setup after loading the view.
    }
   
}
