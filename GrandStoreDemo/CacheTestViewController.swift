//
//  CacheTestViewController.swift
//  GrandStoreDemo
//
//  Created by Tyrant on 1/6/16.
//  Copyright © 2016 Qfq. All rights reserved.
//

import UIKit

class CacheTestViewController: UIViewController {
    var demo1 = GrandStore(name: "CacheTest", defaultValue: "", timeout: 10)
    var txtString:UITextField?
    var txtTimeout:UITextField?
    var btnSet:UIButton?
    var btnGet:UIButton?
    var lblString:UILabel?
    var btnSetCacheTime:UIButton?
    var btnClearCache:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        txtString = UITextField(frame: CGRect(x: 20, y: 67, width: UIScreen.mainScreen().bounds.width - 40, height: 40))
        txtString?.borderStyle = UITextBorderStyle.RoundedRect
        txtString?.placeholder = "你要设定的值"
        txtString?.text = "你要设置的值"
        view.addSubview(txtString!)
        
        txtTimeout = UITextField(frame: CGRect(x: 20, y: CGRectGetMaxY(txtString!.frame) + 10, width: UIScreen.mainScreen().bounds.width - 40, height: 40))
        txtTimeout?.borderStyle = UITextBorderStyle.RoundedRect
        txtTimeout?.keyboardType = UIKeyboardType.NumberPad
        txtTimeout?.placeholder = "缓存时间"
        view.addSubview(txtTimeout!)
        
        btnSet = UIButton(frame: CGRect(x: 10, y: CGRectGetMaxY(txtTimeout!.frame), width: UIScreen.mainScreen().bounds.width / 3 - 20, height: 40))
        btnSet?.setTitle("设值", forState: UIControlState.Normal)
        btnSet?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnSet?.addTarget(self, action: #selector(CacheTestViewController.setString(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnSet!)
        
        
        btnGet = UIButton(frame: CGRect(x: CGRectGetMaxX(btnSet!.frame) + 10, y: CGRectGetMaxY(txtTimeout!.frame), width: UIScreen.mainScreen().bounds.width / 3 - 20, height: 40))
        btnGet?.setTitle("取值", forState: UIControlState.Normal)
        btnGet?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnGet?.addTarget(self, action: #selector(CacheTestViewController.getString(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnGet!)
        
        btnSetCacheTime = UIButton(frame: CGRect(x: CGRectGetMaxX(btnGet!.frame) + 10, y: CGRectGetMaxY(txtTimeout!.frame), width: UIScreen.mainScreen().bounds.width / 3 , height: 40))
        btnSetCacheTime?.setTitle("设定缓存时间", forState: UIControlState.Normal)
        btnSetCacheTime?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnSetCacheTime?.addTarget(self, action: #selector(CacheTestViewController.setCacheTime(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnSetCacheTime!)
        
        lblString = UILabel(frame: CGRect(x: 20, y:CGRectGetMaxY(btnGet!.frame), width: UIScreen.mainScreen().bounds.width - 40, height: 40))
        lblString?.textColor = UIColor.blackColor()
        lblString?.numberOfLines = 0
        lblString?.font = UIFont.systemFontOfSize(12)
        view.addSubview(lblString!)
        
        btnClearCache = UIButton(frame: CGRect(x:  10, y: CGRectGetMaxY(lblString!.frame), width: UIScreen.mainScreen().bounds.width / 3 , height: 40))
        btnClearCache?.setTitle("清空缓存", forState: UIControlState.Normal)
        btnClearCache?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnClearCache?.addTarget(self, action: #selector(CacheTestViewController.clearCache(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnClearCache!)
        
    }
    
    func setString(sender:UIButton)
    {
        if let txt = txtString?.text{
            demo1.Value = txt
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtTimeout?.resignFirstResponder()
        txtString?.resignFirstResponder()
    }
    
    func getString(sender:UIButton)
    {
        lblString?.text = demo1.Value
    }
    
    func setCacheTime(sender:UIButton){
        if txtTimeout?.text != ""{
            demo1.setCacheTime(Int(txtTimeout!.text!)!)
        }
        
    }
    func clearCache(sender:UIButton){
        demo1.clear()
        lblString?.text = "成功清空缓存"
    }
}
