//
//  ResultCell.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/10/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var resultUnit: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
