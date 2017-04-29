//
//  velocityClassTableViewCell.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/27/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class velocityClassTableViewCell: UITableViewCell {

    @IBOutlet weak var dynamicPressureList: UILabel!
    @IBOutlet weak var dynamicPressureTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
