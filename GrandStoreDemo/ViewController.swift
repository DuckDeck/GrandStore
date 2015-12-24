//
//  ViewController.swift
//  GrandStoreDemo
//
//  Created by Tyrant on 12/23/15.
//  Copyright © 2015 Qfq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var demo1 = G_S(name: "demo1", defaultValue: "")
    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var lbl1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func setValue(sender: AnyObject) {
        if txt1.text != nil{
            demo1.Value = txt1.text
        }
    }
    
    @IBAction func getValue(sender: AnyObject) {
        lbl1.text = demo1.Value
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

