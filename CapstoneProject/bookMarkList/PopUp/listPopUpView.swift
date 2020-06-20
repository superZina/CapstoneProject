//
//  listPopUpView.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/13.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import BEMCheckBox

class listPopUpView: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var it: BEMCheckBox!
    @IBOutlet weak var edu: BEMCheckBox!
    @IBOutlet weak var library: BEMCheckBox!
    @IBOutlet weak var student: BEMCheckBox!
    @IBOutlet weak var domitory: BEMCheckBox!
    var selected:[Int] = []
    var checkBoxes:[BEMCheckBox] = []
    override func viewDidLoad() {
        it.tag = 0
        edu.tag = 1
        library.tag = 2
        student.tag = 3
        domitory.tag = 4
        checkBoxes = [it,edu,library,student,domitory]
        
        super.viewDidLoad()
                
        self.editBtn.layer.cornerRadius = 5
        self.domitory.layer.cornerRadius = 5
        self.itLabel.layer.cornerRadius = 5
        self.stuLabel.layer.cornerRadius = 5
        self.libLabel.layer.cornerRadius = 5
        self.eduLabel.layer.cornerRadius = 5
        
    }
    @IBOutlet weak var itLabel: UILabel!
    @IBOutlet weak var domLabel: UILabel!
    @IBOutlet weak var stuLabel: UILabel!
    @IBOutlet weak var libLabel: UILabel!
    @IBOutlet weak var eduLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBAction func edit(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
        for box in checkBoxes {
            if box.on == true {
                selected.append(box.tag)
            }
        }
        UserDefaults.standard.set(selected, forKey: "selected")
        self.navigationController?.popViewController(animated: true)
    }
}

extension listPopUpView: BEMCheckBoxDelegate{
    func didTap(_ checkBox: BEMCheckBox) {
        let currentTag = checkBox.tag
        
        for box in checkBoxes where box.tag != currentTag {
            box.on = false
        }
    }
}
