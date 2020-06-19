//
//  busStopListViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class busStopListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var busStop:[String] = ["IT대학교", "교육대학원","학생회관","기숙사","예술대학"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        busStop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = busStopTable.dequeueReusableCell(withIdentifier: "busStopCell") as? busStopTableViewCell else {return UITableViewCell()}
        cell.busStopName.setTitle(busStop[indexPath.row], for: .normal)
        cell.busStopName.addTarget(self, action: #selector(seeLocation(_:)), for: .allTouchEvents)
        cell.seePeople.addTarget(self, action: #selector(seePeople(_:)), for: .allTouchEvents)
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
    @objc func seeLocation(_ sender: UIButton){
        self.tabBarController?.selectedIndex = 0
        let mainVC = self.tabBarController?.viewControllers![0] as? mainView
        for annotation in mainVC!.mainMap.annotations {
            if annotation.title == sender.titleLabel?.text {
                mainVC!.mainMap.selectAnnotation(annotation, animated: true)
            }
        }
        
    }
    @objc func seePeople(_ sender: UIButton) {

        let busStopViewStoryboard =  UIStoryboard(name: "presentBusStop", bundle: Bundle.main)
        guard let PopUp = busStopViewStoryboard
            .instantiateViewController(withIdentifier: "presentBusStop") as? presentBusStopViewController else {
                print("there's no popup")
                return
        }

        PopUp.modalPresentationStyle = .custom
        self.present(PopUp, animated: true, completion: nil)

    }
}
