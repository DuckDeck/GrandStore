//
//  G_S.swift
//  GrandStoreDemo
//
//  Created by Tyrant on 12/23/15.
//  Copyright © 2015 Qfq. All rights reserved.
//

import Foundation

class G_S<T> {
    private var name:String!
    private var value:T?
    private var defaultValue:T?
    private var hasValue:Bool = false
    private var timeOut:Int = 0
    private var storeLevel:Int = 0
    
    init(name:String,defaultValue:T) {
        self.name = name;
        self.defaultValue = defaultValue;
        storeLevel = self.getStoreLevel()
    }
    
    var Value:T
        {
        get
        {
            if !hasValue
            {
                if storeLevel == 0 //如果存储等级为0,那么从userdefault取
                {
                    
                    if G_S.settingData().objectForKey(name) == nil //如果取不出来
                    {
                        self.value = self.defaultValue;
                        G_S.settingData().setObject(self.value! as? AnyObject, forKey: self.name)
                        G_S.settingData().synchronize()
                        hasValue = true
                    }
                    else
                    {
                        self.value = G_S.settingData().objectForKey(self.name) as? T
                        hasValue = true
                    }
                }
                if storeLevel == 1 //这是用归档保存, 日后处理
                {
                    self.value = self.defaultValue;
                }
            }
            return self.value!
        }
        set
        {
            self.value = newValue
            if storeLevel == 0
            {
                G_S.settingData().setObject(self.value! as? AnyObject, forKey: self.name)
                G_S.settingData().synchronize()
            }
            if storeLevel == 1  //这是用归档保存, 日后处理
            {
                
            }
            hasValue = true
        }
    }
    
    
    private func getStoreLevel()->Int
    {
        if self.defaultValue! is Int || self.defaultValue! is String || self.defaultValue! is NSDate || self.defaultValue! is Bool || self.defaultValue! is Float || self.defaultValue! is Double
        {
            return 0
        }
        return 1
    }
    
    private static func settingData()->NSUserDefaults
    {
        return NSUserDefaults.standardUserDefaults()
    }
}


class GrandCache {
    
}
