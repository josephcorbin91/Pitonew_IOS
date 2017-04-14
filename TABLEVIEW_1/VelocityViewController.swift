//
//  VelocityViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class VelocityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func insertVelocity(_ sender: UIBarButtonItem) {
    }
    
    var items = ["1","2","2"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "velocityCell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var dynamicVelocityTextField: UITextField!
    
    @IBAction func insert(_ sender: UIButton) {
        items.append(dynamicVelocityTextField.text!)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: .fade)
        tableView.endUpdates()
        
        
        
    }
    @IBOutlet weak var tableView: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
