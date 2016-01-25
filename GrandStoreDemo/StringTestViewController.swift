//
//  StringTestViewController.swift
//  GrandStoreDemo
//
//  Created by Tyrant on 12/24/15.
//  Copyright © 2015 Qfq. All rights reserved.
//

import UIKit

class StringTestViewController: UIViewController {
    var demo1 = GrandStore(name: "DemoText", defaultValue: "")
    var txtString:UITextField?
    var btnSet:UIButton?
    var btnGet:UIButton?
    var lblString:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        txtString = UITextField(frame: CGRect(x: 20, y: 67, width: UIScreen.mainScreen().bounds.width - 40, height: 40))
        txtString?.layer.borderColor = UIColor.blueColor().CGColor
        txtString?.layer.borderWidth = 0.5
        view.addSubview(txtString!)
        
        btnSet = UIButton(frame: CGRect(x: 20, y: CGRectGetMaxY(txtString!.frame), width: UIScreen.mainScreen().bounds.width - 40, height: 40))
        btnSet?.setTitle("设值", forState: UIControlState.Normal)
        btnSet?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnSet?.addTarget(self, action: "setString:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnSet!)
        
        
        btnGet = UIButton(frame: CGRect(x: 20, y: CGRectGetMaxY(btnSet!.frame), width: UIScreen.mainScreen().bounds.width - 40, height: 40))
        btnGet?.setTitle("取值", forState: UIControlState.Normal)
        btnGet?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnGet?.addTarget(self, action: "getString:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnGet!)
        
        
        lblString = UILabel(frame: CGRect(x: 20, y:CGRectGetMaxY(btnGet!.frame), width: UIScreen.mainScreen().bounds.width - 40, height: 40))
        lblString?.textColor = UIColor.blackColor()
        view.addSubview(lblString!)
    }
    
    func setString(sender:UIButton)
    {
        if let txt = txtString?.text{
            demo1.Value = txt
           demo1.removeObserver()
        }
    }
    
    func getString(sender:UIButton)
    {
        lblString?.text = demo1.Value
    }
}
