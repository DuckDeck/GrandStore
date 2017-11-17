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
    var btnRemoveObserver:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        txtName = UITextField(frame: CGRect(x: 10, y: 80, width: UIScreen.main.bounds.size.width / 2 - 20, height: 40))
        txtName?.placeholder = "姓名"
        txtName?.text = "Optimus"
        txtName?.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(txtName!)
        txtAge = UITextField(frame: CGRect(x: txtName!.frame.maxX+10, y: txtName!.frame.origin.y, width: UIScreen.main.bounds.size.width / 2 - 20, height: 40))
        txtAge?.placeholder = "年龄"
        txtAge?.text = "11"
        txtAge?.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(txtAge!)
        
        txtProvince = UITextField(frame: CGRect(x: 10, y: txtAge!.frame.maxY+5, width: UIScreen.main.bounds.size.width / 2 - 20, height: 40))
        txtProvince?.placeholder = "省"
        txtProvince?.text = "广东省"
        txtProvince?.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(txtProvince!)
        
        txtCity = UITextField(frame: CGRect(x: txtName!.frame.maxX+10, y: txtProvince!.frame.origin.y, width: UIScreen.main.bounds.size.width / 2 - 20, height: 40))
        txtCity?.placeholder = "市"
        txtCity?.text = "深圳市"
        txtCity?.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(txtCity!)
        
        txtDistrict = UITextField(frame: CGRect(x: 10, y: txtCity!.frame.maxY+5, width: UIScreen.main.bounds.size.width - 20, height: 40))
        txtDistrict?.placeholder = "区"
        txtDistrict?.text = "南山区"
        txtDistrict?.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(txtDistrict!)
        
        txtStreet = UITextField(frame: CGRect(x: 10, y: txtDistrict!.frame.maxY+5, width: UIScreen.main.bounds.size.width - 20, height: 40))
        txtStreet?.placeholder = "街道"
        txtStreet?.text = "XXXX路XXXX栋XXXX楼"
        txtStreet?.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(txtStreet!)
        
        btnSetStudent = UIButton(frame: CGRect(x: 10, y: txtStreet!.frame.maxY, width: UIScreen.main.bounds.size.width / 3 - 20, height: 40))
        btnSetStudent?.setTitle("设置", for: UIControlState())
        btnSetStudent?.setTitleColor(UIColor.black, for: UIControlState())
        btnSetStudent?.addTarget(self, action: #selector(ObjectTestViewController.setStudent(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnSetStudent!)
        
        btnGetStudent = UIButton(frame: CGRect(x: btnSetStudent!.frame.maxX, y: txtStreet!.frame.maxY, width: UIScreen.main.bounds.size.width / 3 - 20, height: 40))
        btnGetStudent?.setTitle("取置", for: UIControlState())
        btnGetStudent?.setTitleColor(UIColor.black, for: UIControlState())
        btnGetStudent?.addTarget(self, action: #selector(ObjectTestViewController.getStudent(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnGetStudent!)
        
        lblStudent = UILabel(frame: CGRect(x: 10, y: btnSetStudent!.frame.maxY, width: UIScreen.main.bounds.size.width - 20, height: 100))
        lblStudent?.numberOfLines = 0
        lblStudent?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(lblStudent!)
        
        btnClear = UIButton(frame: CGRect(x:  btnGetStudent!.frame.maxX, y: btnGetStudent!.frame.origin.y, width: UIScreen.main.bounds.size.width / 3 - 20, height: 40))
        btnClear?.setTitle("清空", for: UIControlState())
        btnClear?.setTitleColor(UIColor.black, for: UIControlState())
        btnClear?.addTarget(self, action: #selector(ObjectTestViewController.clearStudent(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnClear!)
        
        btnAddAbserver = UIButton(frame: CGRect(x:  10, y: lblStudent!.frame.maxY, width: UIScreen.main.bounds.size.width / 3 - 20, height: 40))
        btnAddAbserver?.setTitle("添加观察", for: UIControlState())
        btnAddAbserver?.setTitleColor(UIColor.black, for: UIControlState())
        btnAddAbserver?.addTarget(self, action: #selector(ObjectTestViewController.addObserver(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnAddAbserver!)
        
        
        btnRemoveObserver = UIButton(frame: CGRect(x:  btnAddAbserver!.frame.maxX + 5, y: lblStudent!.frame.maxY, width: UIScreen.main.bounds.size.width / 3 - 20, height: 40))
        btnRemoveObserver?.setTitle("移除观察", for: UIControlState())
        btnRemoveObserver?.setTitleColor(UIColor.black, for: UIControlState())
        btnRemoveObserver?.addTarget(self, action: #selector(ObjectTestViewController.removeObserver(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btnRemoveObserver!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtAge?.resignFirstResponder()
        txtName?.resignFirstResponder()
        txtCity?.resignFirstResponder()
        txtDistrict?.resignFirstResponder()
        txtStreet?.resignFirstResponder()
        txtProvince?.resignFirstResponder()
        
    }
    
    @objc func setStudent(_ sender:UIButton){
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
    @objc func getStudent(_ sender:UIButton){
        if stu.Value?.name != ""{
            let student = stu.Value!
            lblStudent?.text = "Name:\(student.name) id:\(student.id) age:\(student.age) address:\(student.address.provice)-\(student.address.city)-\(student.address.district)-\(student.address.street) "
        }
        else{
            lblStudent?.text = "";
        }
    }
    @objc func clearStudent(_ sender:UIButton)
    {
        stu.clear()
        lblStudent?.text = "已经清空"
    }
    @objc func addObserver(_ sender:UIButton){
        stu.addObserver { (observerObject, observerKey, oldValue, newValue) -> Void in
              self.lblStudent?.text = "old:\(oldValue.debugDescription), new:\(newValue.debugDescription)"
        }
     lblStudent?.text = "已经添加观察"
     
    }
    
    @objc func removeObserver(_ sender:UIButton){
        stu.removeObserver()
         lblStudent?.text = "已经移除观察"
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
    @objc func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(address, forKey: "address")
    }
    @objc required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        age = aDecoder.decodeInteger(forKey: "age")
        id = aDecoder.decodeInteger(forKey: "id")
        address = aDecoder.decodeObject(forKey: "address") as! Address
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
    
    @objc func encode(with aCoder: NSCoder) {
        aCoder.encode(city, forKey: "city")
        aCoder.encode(provice, forKey: "provice")
        aCoder.encode(district, forKey: "district")
        aCoder.encode(street, forKey: "street")
    }
    @objc required init?(coder aDecoder: NSCoder) {
        city = aDecoder.decodeObject(forKey: "city") as! String
        provice = aDecoder.decodeObject(forKey: "provice") as! String
        district = aDecoder.decodeObject(forKey: "district") as! String
        street = aDecoder.decodeObject(forKey: "street") as! String
    }
    func desciption()->String{
        return "province:\(provice) city\(city) district \(district) street \(street)"
    }
    override  var debugDescription:String{
        return self.desciption()
    }
}
