//
//  ArrayTestViewController.swift
//  GrandStoreDemo
//
//  Created by Tyrant on 12/25/15.
//  Copyright © 2015 Qfq. All rights reserved.
//

import UIKit

class ArrayTestViewController: UIViewController {
    let arrTest = GrandStore(name: "arrTest", defaultValue: [String]())
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
        txtString?.keyboardType = UIKeyboardType.NumberPad
        view.addSubview(txtString!)
        
        btnSet = UIButton(frame: CGRect(x: 20, y: CGRectGetMaxY(txtString!.frame), width: UIScreen.mainScreen().bounds.width - 40, height: 40))
        btnSet?.setTitle("添加", forState: UIControlState.Normal)
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
            var arr = arrTest.Value
            arr?.append(txt)
            arrTest.Value = arr
            lblString?.text = "\(txt)成功添加到数组"
        }
    }
    
    func getString(sender:UIButton)
    {
        var str = ""
        for s in arrTest.Value!{
            str += s
        }
        lblString?.text = str
    }
}

