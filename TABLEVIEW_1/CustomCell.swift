//
//  CustomCell.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/9/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {


    @IBOutlet weak var backgrondView: UIView!

    
    @IBOutlet weak var inputTextField: UITextField!
  
    @IBOutlet weak var inputUnitLabel: UILabel!
    @IBOutlet weak var inputTitle: UILabel!

/*
    @IBOutlet weak var inputUnitLabel: UILabel!
    @IBOutlet weak var inputTitle: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
 */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected == true){
        inputTextField.becomeFirstResponder()
        }
        
        
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /* Initialization code
      //  backgrondView.backgroundColor = UIColor.white
  //      backgrondView.alpha = 0.5
        contentView.backgroundColor = UIColor.white
       
        
        backgrondView.layer.cornerRadius = 3.0
        backgrondView.layer.masksToBounds = false
        backgrondView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgrondView.layer.shadowOpacity = 0.8
        */
    }
    

}
