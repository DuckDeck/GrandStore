//
//  ObjectTestViewController.swift
//  GrandStoreDemo
//
//  Created by Tyrant on 1/5/16.
//  Copyright © 2016 Qfq. All rights reserved.
//

import UIKit

class ObjectTestViewController: UIViewController {
    let stu = GrandStore(name: "student", defaultValue: Student())
     var txtName:UITextField?
    var txtAge:UITextField?
    var txtProvince:UITextField?
    var txtCity:UITextField?
    var txtDistrict:UITextField?
    var txtStreet:UITextField?
    var btnSetStudent:UIButton?
    var btnGetStudent:UIButton?
    var lblStudent:UILabel?
    var btnClear:UIButton?
    var btnAddAbserver:UIButton?
    var removeObserver:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        txtName = UITextField(frame: CGRect(x: 10, y: 80, width: UIScreen.mainScreen().bounds.size.width / 2 - 20, height: 40))
        txtName?.placeholder = "姓名"
        txtName?.text = "Optimus"
        txtName?.borderStyle = UITextBorderStyle.RoundedRect
        view.addSubview(txtName!)
        txtAge = UITextField(frame: CGRect(x: CGRectGetMaxX(txtName!.frame)+10, y: txtName!.frame.origin.y, width: UIScreen.mainScreen().bounds.size.width / 2 - 20, height: 40))
        txtAge?.placeholder = "年龄"
        txtAge?.text = "11"
        txtAge?.borderStyle = UITextBorderStyle.RoundedRect
        view.addSubview(txtAge!)
        
        txtProvince = UITextField(frame: CGRect(x: 10, y: CGRectGetMaxY(txtAge!.frame)+5, width: UIScreen.mainScreen().bounds.size.width / 2 - 20, height: 40))
        txtProvince?.placeholder = "省"
        txtProvince?.text = "广东省"
        txtProvince?.borderStyle = UITextBorderStyle.RoundedRect
        view.addSubview(txtProvince!)
        
        txtCity = UITextField(frame: CGRect(x: CGRectGetMaxX(txtName!.frame)+10, y: txtProvince!.frame.origin.y, width: UIScreen.mainScreen().bounds.size.width / 2 - 20, height: 40))
        txtCity?.placeholder = "市"
        txtCity?.text = "深圳市"
        txtCity?.borderStyle = UITextBorderStyle.RoundedRect
        view.addSubview(txtCity!)
        
        txtDistrict = UITextField(frame: CGRect(x: 10, y: CGRectGetMaxY(txtCity!.frame)+5, width: UIScreen.mainScreen().bounds.size.width - 20, height: 40))
        txtDistrict?.placeholder = "区"
        txtDistrict?.text = "南山区"
        txtDistrict?.borderStyle = UITextBorderStyle.RoundedRect
        view.addSubview(txtDistrict!)
        
        txtStreet = UITextField(frame: CGRect(x: 10, y: CGRectGetMaxY(txtDistrict!.frame)+5, width: UIScreen.mainScreen().bounds.size.width - 20, height: 40))
        txtStreet?.placeholder = "街道"
        txtStreet?.text = "XXXX路XXXX栋XXXX楼"
        txtStreet?.borderStyle = UITextBorderStyle.RoundedRect
        view.addSubview(txtStreet!)
        
        btnSetStudent = UIButton(frame: CGRect(x: 10, y: CGRectGetMaxY(txtStreet!.frame), width: UIScreen.mainScreen().bounds.size.width / 3 - 20, height: 40))
        btnSetStudent?.setTitle("设置", forState: UIControlState.Normal)
        btnSetStudent?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnSetStudent?.addTarget(self, action: "setStudent:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnSetStudent!)
        
        btnGetStudent = UIButton(frame: CGRect(x: CGRectGetMaxX(btnSetStudent!.frame), y: CGRectGetMaxY(txtStreet!.frame), width: UIScreen.mainScreen().bounds.size.width / 3 - 20, height: 40))
        btnGetStudent?.setTitle("取置", forState: UIControlState.Normal)
        btnGetStudent?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnGetStudent?.addTarget(self, action: "getStudent:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnGetStudent!)
        
        lblStudent = UILabel(frame: CGRect(x: 10, y: CGRectGetMaxY(btnSetStudent!.frame), width: UIScreen.mainScreen().bounds.size.width - 20, height: 100))
        lblStudent?.numberOfLines = 0
        lblStudent?.font = UIFont.systemFontOfSize(12)
        view.addSubview(lblStudent!)
        
        btnClear = UIButton(frame: CGRect(x:  CGRectGetMaxX(btnGetStudent!.frame), y: btnGetStudent!.frame.origin.y, width: UIScreen.mainScreen().bounds.size.width / 3 - 20, height: 40))
        btnClear?.setTitle("清空", forState: UIControlState.Normal)
        btnClear?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnClear?.addTarget(self, action: "clearStudent:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnClear!)
        
        btnAddAbserver = UIButton(frame: CGRect(x:  10, y: CGRectGetMaxY(lblStudent!.frame), width: UIScreen.mainScreen().bounds.size.width / 3 - 20, height: 40))
        btnAddAbserver?.setTitle("添加观察", forState: UIControlState.Normal)
        btnAddAbserver?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnAddAbserver?.addTarget(self, action: "addObserver:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnAddAbserver!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtAge?.resignFirstResponder()
        txtName?.resignFirstResponder()
        txtCity?.resignFirstResponder()
        txtDistrict?.resignFirstResponder()
        txtStreet?.resignFirstResponder()
        txtProvince?.resignFirstResponder()
        
    }
    
    func setStudent(sender:UIButton){
        if txtName?.text == ""{
            lblStudent?.text = "你要填写名字"
            return
        }
        if txtAge?.text == ""{
            txtAge?.text = "你要填写年龄"
            return
        }
        let address = Address()
        if txtCity?.text != ""{
            address.city = txtCity!.text!
        }
        if txtProvince?.text != ""{
            address.provice = txtProvince!.text!
        }
        if txtDistrict?.text != ""{
            address.district = txtDistrict!.text!
        }
        if txtStreet?.text != ""{
            address.street = txtStreet!.text!
        }
        let student = Student(name: txtName!.text!, age: Int(txtAge!.text!)!, address: address)
        self.stu.Value = student
    }
    func getStudent(sender:UIButton){
        if stu.Value?.name != ""{
            let student = stu.Value!
            lblStudent?.text = "Name:\(student.name) id:\(student.id) age:\(student.age) address:\(student.address.provice)-\(student.address.city)-\(student.address.district)-\(student.address.street) "
        }
        else{
            lblStudent?.text = "";
        }
    }
    func clearStudent(sender:UIButton)
    {
        stu.clear()
        lblStudent?.text = "已经清空"
    }
    func addObserver(sender:UIButton){
        stu.addObserver { (observerObject, observerKey, oldValue, newValue) -> Void in
              self.lblStudent?.text = "old:\(oldValue.debugDescription), new:\(newValue.debugDescription)"
        }
     lblStudent?.text = "已经添加观察"
     
    }
    
}
class Student:NSObject, NSCoding {
    var name:String
    var age:Int
    var id:Int
    var address:Address
    override init(){
        self.name = ""
        self.age = 0
        self.id = 0
        self.address = Address()
    }
    init(name:String,age:Int,address:Address){
        self.name = name
        self.age = age
        self.address = address
        id = 1
    }
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(age, forKey: "age")
        aCoder.encodeInteger(id, forKey: "id")
        aCoder.encodeObject(address, forKey: "address")
    }
    @objc required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        age = aDecoder.decodeIntegerForKey("age")
        id = aDecoder.decodeIntegerForKey("id")
        address = aDecoder.decodeObjectForKey("address") as! Address
    }
    func desciption()->String{
        return "name:\(name) age:\(age)id :\(id) address:\(address)"
    }
    
   override  var debugDescription:String{
        return self.desciption()
    }
}


class  Address:NSObject,NSCoding {
    var city:String = ""
    var provice:String = ""
    var district:String = ""
    var street:String = ""
    
    override init(){
        
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(city, forKey: "city")
        aCoder.encodeObject(provice, forKey: "provice")
        aCoder.encodeObject(district, forKey: "district")
        aCoder.encodeObject(street, forKey: "street")
    }
    @objc required init?(coder aDecoder: NSCoder) {
        city = aDecoder.decodeObjectForKey("city") as! String
        provice = aDecoder.decodeObjectForKey("provice") as! String
        district = aDecoder.decodeObjectForKey("district") as! String
        street = aDecoder.decodeObjectForKey("street") as! String
    }
    func desciption()->String{
        return "province:\(provice) city\(city) district \(district) street \(street)"
    }
    override  var debugDescription:String{
        return self.desciption()
    }
}