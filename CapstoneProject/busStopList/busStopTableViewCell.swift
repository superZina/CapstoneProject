//
//  busStopTableViewCell.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/06/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class busStopTableViewCell: UITableViewCell {

    @IBOutlet weak var seePeople: UIButton!
    @IBOutlet weak var busStopName: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
