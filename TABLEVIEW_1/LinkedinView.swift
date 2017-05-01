//
//  LinkedinView.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 5/1/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class LinkedinView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: "http://www.nba.com");
        let requestObj = NSURLRequest(url: url! as URL);
        webview.loadRequest(requestObj as URLRequest);
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var webview: UIWebView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
