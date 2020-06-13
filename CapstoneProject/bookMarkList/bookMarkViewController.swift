//
//  bookMarkViewController.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/13.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class bookMarkViewController: UIViewController {

    @IBOutlet weak var bookMarkTable: UITableView!
    var total:[String] = []
    var selected:[String] = []
    var selectedIndex:[Int] = []
    @IBAction func editBookMark(_ sender: Any) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        total = ["IT대학교", "교육대학원","중앙도서관","학생회관","기숙사"]
            }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bookMarkTable.reloadData()
        selectedIndex = UserDefaults.standard.value(forKey: "selected") as! [Int]
        var newSelected:[String] = []
        for i in selectedIndex {
            newSelected.append(total[i])
        }
        selected = newSelected
        print(selected)
        let bookMarkNib = UINib(nibName: "bookMarkTableViewCell", bundle: nil)
        self.bookMarkTable.delegate = self
        self.bookMarkTable.dataSource = self
        self.bookMarkTable.register(bookMarkNib, forCellReuseIdentifier: "bookMarkCell")
        self.bookMarkTable.estimatedRowHeight = 650.0
        self.bookMarkTable.reloadData()
    }
}

extension bookMarkViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookMarkTable.dequeueReusableCell(withIdentifier: "bookMarkCell") as? bookMarkTableViewCell else {return UITableViewCell()}
        cell.Name.text = selected[indexPath.row] + " 정류장"
        cell.location.text = selected[indexPath.row] + " 앞"
        return cell
    }
    
    
}
