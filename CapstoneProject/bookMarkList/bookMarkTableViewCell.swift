//
//  bookMarkTableViewCell.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/13.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class bookMarkTableViewCell: UITableViewCell {

    @IBOutlet weak var seePeople: UIButton!
    @IBOutlet weak var expectTime: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var location: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
