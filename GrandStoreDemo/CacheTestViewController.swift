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
        view.backgroundColor = UIColor.white
        txtString = UITextField(frame: CGRect(x: 20, y: 67, width: UIScreen.main.bounds.width - 40, height: 40))
        txtString?.borderStyle = UITextBorderStyle.roundedRect
        txtString?.placeholder = "你要设定的值"
        txtString?.text = "你要设置的值"
        view.addSubview(txtString!)
        
        txtTimeout = UITextField(frame: CGRect(x: 20, y: txtString!.frame.maxY + 10, width: UIScreen.main.bounds.width - 40, height: 40))
        txtTimeout?.borderStyle = UITextBorderStyle.roundedRect
        txtTimeout?.keyboardType = UIKeyboardType.numberPad
        txtTimeout?.placeholder = "缓存时间"
        view.addSubview(txtTimeout!)
        
        btnSet = UIButton(frame: CGRect(x: 10, y: txtTimeout!.frame.maxY, width: UIScreen.main.bounds.width / 3 - 20, height: 40))
        btnSet?.setTitle("设值", for: UIControlState())
        btnSet?.setTitleColor(UIColor.black, for: UIControlState())
        btnSet?.addTarget(self, action: #selector(CacheTestViewController.setString(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnSet!)
        
        
        btnGet = UIButton(frame: CGRect(x: btnSet!.frame.maxX + 10, y: txtTimeout!.frame.maxY, width: UIScreen.main.bounds.width / 3 - 20, height: 40))
        btnGet?.setTitle("取值", for: UIControlState())
        btnGet?.setTitleColor(UIColor.black, for: UIControlState())
        btnGet?.addTarget(self, action: #selector(CacheTestViewController.getString(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnGet!)
        
        btnSetCacheTime = UIButton(frame: CGRect(x: btnGet!.frame.maxX + 10, y: txtTimeout!.frame.maxY, width: UIScreen.main.bounds.width / 3 , height: 40))
        btnSetCacheTime?.setTitle("设定缓存时间", for: UIControlState())
        btnSetCacheTime?.setTitleColor(UIColor.black, for: UIControlState())
        btnSetCacheTime?.addTarget(self, action: #selector(CacheTestViewController.setCacheTime(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnSetCacheTime!)
        
        lblString = UILabel(frame: CGRect(x: 20, y:btnGet!.frame.maxY, width: UIScreen.main.bounds.width - 40, height: 40))
        lblString?.textColor = UIColor.black
        lblString?.numberOfLines = 0
        lblString?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(lblString!)
        
        btnClearCache = UIButton(frame: CGRect(x:  10, y: lblString!.frame.maxY, width: UIScreen.main.bounds.width / 3 , height: 40))
        btnClearCache?.setTitle("清空缓存", for: UIControlState())
        btnClearCache?.setTitleColor(UIColor.black, for: UIControlState())
        btnClearCache?.addTarget(self, action: #selector(CacheTestViewController.clearCache(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnClearCache!)
        
    }
    
    func setString(_ sender:UIButton)
    {
        if let txt = txtString?.text{
            demo1.Value = txt
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtTimeout?.resignFirstResponder()
        txtString?.resignFirstResponder()
    }
    
    func getString(_ sender:UIButton)
    {
        lblString?.text = demo1.Value
    }
    
    func setCacheTime(_ sender:UIButton){
        if txtTimeout?.text != ""{
            demo1.setCacheTime(Int(txtTimeout!.text!)!)
        }
        
    }
    func clearCache(_ sender:UIButton){
        demo1.clear()
        lblString?.text = "成功清空缓存"
    }
}
