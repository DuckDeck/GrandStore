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
    var arrMenu:[String] = ["测试字符串","测试数","测试数组和字典","测试自定义对象","测试缓存","测试暂存"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Demo"
        tbMenu = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tbMenu?.dataSource = self
        tbMenu?.delegate = self
        tbMenu?.tableFooterView = UIView()
        view.addSubview(tbMenu!)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = arrMenu[(indexPath as NSIndexPath).row]
        return cell!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch((indexPath as NSIndexPath).row){
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
        case 5:
            navigationController?.pushViewController(TempSaveTestViewController(), animated: true)
        default:break
            
        }
    }

}

