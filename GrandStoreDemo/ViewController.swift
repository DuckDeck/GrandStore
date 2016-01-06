//
//  ViewController.swift
//  GrandStoreDemo
//
//  Created by Tyrant on 12/23/15.
//  Copyright © 2015 Qfq. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var tbMenu:UITableView?
    var arrMenu:[String] = ["测试字符串","测试数","测试数组和字典","测试自定义对象","测试缓存"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Demo"
        tbMenu = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        tbMenu?.dataSource = self
        tbMenu?.delegate = self
        tbMenu?.tableFooterView = UIView()
        view.addSubview(tbMenu!)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = arrMenu[indexPath.row]
        return cell!
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row){
        case 0:
            let stringViewController = StringTestViewController()
            navigationController?.pushViewController(stringViewController, animated: true)
        case 1:
            let numberViewController = NumberTestViewController()
            navigationController?.pushViewController(numberViewController, animated: true)
        case 2:
            let arrayViewController = ArrayTestViewController()
            navigationController?.pushViewController(arrayViewController, animated: true)
        case 3:
            let objectTestViewController = ObjectTestViewController()
            navigationController?.pushViewController(objectTestViewController, animated: true)
        case 4:
            let cacheTestViewController = CacheTestViewController()
            navigationController?.pushViewController(cacheTestViewController, animated: true)

        default:break
            
        }
    }

}

