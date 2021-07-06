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
        view.backgroundColor = UIColor.white
        txtString = UITextField(frame: CGRect(x: 20, y: 167, width: UIScreen.main.bounds.width - 40, height: 40))
        txtString?.layer.borderColor = UIColor.blue.cgColor
        txtString?.layer.borderWidth = 0.5
        txtString?.keyboardType = UIKeyboardType.numberPad
        view.addSubview(txtString!)
        
        btnSet = UIButton(frame: CGRect(x: 20, y: txtString!.frame.maxY, width: UIScreen.main.bounds.width - 40, height: 40))
        btnSet?.setTitle("添加", for: UIControl.State())
        btnSet?.setTitleColor(UIColor.black, for: UIControl.State())
        btnSet?.addTarget(self, action: #selector(ArrayTestViewController.setString(_:)), for: UIControl.Event.touchUpInside)
        view.addSubview(btnSet!)
        
        
        btnGet = UIButton(frame: CGRect(x: 20, y: btnSet!.frame.maxY, width: UIScreen.main.bounds.width - 40, height: 40))
        btnGet?.setTitle("取值", for: UIControl.State())
        btnGet?.setTitleColor(UIColor.black, for: UIControl.State())
        btnGet?.addTarget(self, action: #selector(ArrayTestViewController.getString(_:)), for: UIControl.Event.touchUpInside)
        view.addSubview(btnGet!)
        
        
        lblString = UILabel(frame: CGRect(x: 20, y:btnGet!.frame.maxY, width: UIScreen.main.bounds.width - 40, height: 40))
        lblString?.textColor = UIColor.black
        view.addSubview(lblString!)
    }
    @objc func setString(_ sender:UIButton)
    {
        if let txt = txtString?.text{
//            var arr = arrTest.Value
//            arr?.append(txt)
//            arrTest.Value = arr
         _ =   arrTest.appendWith(txt as AnyObject)
            lblString?.text = "\(txt)成功添加到数组"
        }
    }
    
    @objc func getString(_ sender:UIButton)
    {
        var str = ""
        for s in arrTest.Value{
            str += s
        }
        lblString?.text = str
    }
}

