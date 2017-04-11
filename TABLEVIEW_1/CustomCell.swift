//
//  CustomCell.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/9/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
  


    @IBOutlet weak var inputUnitLabel: UILabel!
    @IBOutlet weak var inputTitle: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected == true){
        inputTextField.becomeFirstResponder()
        }
        
        
        // Configure the view for the selected state
    }

}
