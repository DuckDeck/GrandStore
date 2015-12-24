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
        if self.defaultValue! is Int || self.defaultValue! is String || self.defaultValue! is NSDate || self.defaultValue! is Bool || self.defaultValue! is Float || self.defaultValue! is Double || self.defaultValue! is NSData
        { //need test NSData can store in the NSUserDefaults, I whether it need store the NSArray or NSdictonary
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
    // Not turn EGOCahce to swift laguage
    private static let sharedInstance = GrandCache()
    class  var globleCache:GrandCache {
        return sharedInstance
    }
    
    var cacheInfoQueue:dispatch_queue_t
    var frozenCacheInfoQueue:dispatch_queue_t
    var diskQueue:dispatch_queue_t
    var cacheInfo:[String:NSDate]
    var directory:String
    var needSave:Bool = true
    var frozenCacheInfo:[String:NSDate]
    var defaultTimeoutInterval:NSTimeInterval = 86400
    init(){
        var cacheDirectory:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let oldCacheDirectroy = (cacheDirectory.stringByAppendingPathComponent(NSProcessInfo.processInfo().processName) as NSString).stringByAppendingPathComponent("GrandStore")
        if NSFileManager.defaultManager().fileExistsAtPath(oldCacheDirectroy){
            if let _ = try? NSFileManager.defaultManager().removeItemAtPath(oldCacheDirectroy){
                //do nothing
            }
        }
        cacheDirectory = (cacheDirectory.stringByAppendingPathComponent(NSBundle.mainBundle().bundleIdentifier!) as NSString).stringByAppendingPathComponent("GrandStore")
        
        cacheInfoQueue = dispatch_queue_create("DuckDeck.GrandStore.Info", DISPATCH_QUEUE_SERIAL)
        var priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) //what is this suppose to do......
        dispatch_set_target_queue(priority, cacheInfoQueue)
        
        frozenCacheInfoQueue = dispatch_queue_create("DuckDeck.GrandStore.Frozen", DISPATCH_QUEUE_SERIAL)
        priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        dispatch_set_target_queue(priority, frozenCacheInfoQueue)
        
        diskQueue = dispatch_queue_create("DuckDeck.GrandStore.Disk", DISPATCH_QUEUE_CONCURRENT)
        priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        dispatch_set_target_queue(priority, diskQueue)
        
        directory = cacheDirectory as String
        
        if let  tempCacheInfo = NSDictionary(contentsOfFile: directory + "GrandStore.plist") as? [String:NSDate]{
            cacheInfo = tempCacheInfo
        }
        else{
            cacheInfo = [String:NSDate]()
        }
        if let _ = try? NSFileManager.defaultManager().createDirectoryAtPath(directory, withIntermediateDirectories: true, attributes: nil){
            //do nothing
        }
        let now = NSDate().timeIntervalSinceReferenceDate
        var removedKeys = [String]()
        for key in cacheInfo.keys{
            if cacheInfo[key]?.timeIntervalSinceReferenceDate <= now{
                if let  _  = try? NSFileManager.defaultManager().removeItemAtPath(directory.stringByAppendingString(key.stringByReplacingOccurrencesOfString("/", withString: "_"))) {
                    removedKeys.append(key)
                }
            }
        }
        for key in removedKeys{
            cacheInfo.removeValueForKey(key)
        }
        frozenCacheInfo = cacheInfo
    }
    
    func clearCache(){
        dispatch_sync(cacheInfoQueue) { () -> Void in
            for key in self.cacheInfo.keys{
                if let  _  = try? NSFileManager.defaultManager().removeItemAtPath(self.cachePathForKey(self.directory, key: key)){
                    
                }
            }
            self.cacheInfo.removeAll()
            dispatch_sync(self.frozenCacheInfoQueue, { () -> Void in
                self.frozenCacheInfo = self.cacheInfo
            })
            self.setNeedSave()
        }
    }
    
    func setNeedSave(){
        dispatch_async(cacheInfoQueue) { () -> Void in
            if self.needSave{
                return
            }
            self.needSave = true
            let delayInSeconds = 0.5
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, self.cacheInfoQueue, { () -> Void in
                if !self.needSave {
                    return;
                }
                (self.cacheInfo as NSDictionary).writeToFile(self.cachePathForKey(self.directory, key: "GrandStore.plist"), atomically: true)
                self.needSave = false
            })
        }
    }
    
    
    func removeCacheForKey(key:String){
        if key == "GrandStore.plist"{
            return
        }
        dispatch_async(diskQueue) { () -> Void in
            if let  _  = try?  NSFileManager.defaultManager().removeItemAtPath(self.cachePathForKey(self.directory, key: key)){
                
            }
        }
        self.setCacheTimeoutInterval(0, key: key)
    }
    
    func hasCacheForKey(key:String)->Bool{
        if let date = dateForKey(key){
            if date.timeIntervalSinceReferenceDate < CFAbsoluteTimeGetCurrent(){
                return false
            }
            return NSFileManager.defaultManager().fileExistsAtPath(cachePathForKey(self.directory, key: key))
        }
        else{
            return false
        }
    }
    
    func dateForKey(key:String)->NSDate?{
        var date:NSDate? = nil
        dispatch_sync(self.frozenCacheInfoQueue) { () -> Void in   //why shoudl do this, that's weird,mey be this is for thread lock
            date = self.frozenCacheInfo[key]
        }
        return date
    }
    
    func allKeys()->[String]?{
        var keys:[String]? = nil
        dispatch_sync(self.frozenCacheInfoQueue) { () -> Void in
            for key in self.frozenCacheInfo.keys{ //目前只有这样 了
                keys?.append(key)
            }
        }
        return keys
    }
    
    func setCacheTimeoutInterval(timeoutInterval:NSTimeInterval,key:String){
        let date:NSDate? = timeoutInterval > 0 ? NSDate(timeIntervalSinceNow: timeoutInterval) : nil
        dispatch_sync(frozenCacheInfoQueue) { () -> Void in
            if date != nil{
                self.frozenCacheInfo[key] = date!
            }
            else{
                self.frozenCacheInfo.removeValueForKey(key)
            }
        }
        
        dispatch_async(cacheInfoQueue) { () -> Void in
            if date != nil{
                self.cacheInfo[key] = date
            }
            else
            {
                self.cacheInfo.removeValueForKey(key)
            }
            dispatch_sync(self.frozenCacheInfoQueue, { () -> Void in
                self.frozenCacheInfo = self.cacheInfo
            })
            self.setNeedSave()
        }
    }
    
    
    func copyFilePath(filePath:String,key:String){
        coprFilePath(filePath, key: key, timeoutInterval: defaultTimeoutInterval)
    }
    
    func coprFilePath(filePath:String,key:String,timeoutInterval:NSTimeInterval){
        dispatch_async(diskQueue) { () -> Void in
            if let _ = try? NSFileManager.defaultManager().copyItemAtPath(filePath, toPath: self.cachePathForKey(self.directory, key: key)){
                
            }
        }
        setCacheTimeoutInterval(timeoutInterval, key: key)
    }

    func setData(data:NSData,key:String){
        setData(data, key: key, timeoutInterval: defaultTimeoutInterval)
    }
    
    func setData(data:NSData,key:String,timeoutInterval:NSTimeInterval){
        if key == "GrandStore.plist"{
            return
        }
        let cachePath = cachePathForKey(directory, key: key)
        dispatch_async(self.diskQueue) { () -> Void in
            data.writeToFile(cachePath, atomically: true)
        }
        setCacheTimeoutInterval(timeoutInterval, key: key)
    }
    
    func dataForKey(key:String)->NSData?{
        if hasCacheForKey(key){
            if let data = try? NSData(contentsOfFile: cachePathForKey(directory, key: key), options: NSDataReadingOptions.DataReadingMappedIfSafe){
                return data
            }
            else
            {
                return nil
            }
        }
        else{
            return nil
        }
    }
    
    func stringForKey(key:String)->String?{
        if let data = self.dataForKey(key){
            return String(data: data, encoding: NSUTF8StringEncoding)
        }
        else
        {
            return nil
        }
    }
    
    func setString(str:String,key:String){
        self.setString(str, key: key, timeoutInterval: defaultTimeoutInterval)
    }
    
    func setString(str:String,key:String,timeoutInterval:NSTimeInterval){
        self.setData(str.dataUsingEncoding(NSUTF8StringEncoding)!, key: key, timeoutInterval: timeoutInterval)
    }
    
    //Image就不要了
    //plist 也不要了
    //Object
    func objectForKey(key:String)-> NSCoding?{
        if self.hasCacheForKey(key){
            if let data = self.dataForKey(key){
                return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NSCoding
            }
            else{
                return nil
            }
        }
        return nil
    }
    
    func setObject(obj:NSCoding,key:String){
        setObject(obj, key: key, timeoutInterval: defaultTimeoutInterval)
    }
    
    func setObject(obj:NSCoding,key:String,timeoutInterval:NSTimeInterval){
        self.setData(NSKeyedArchiver.archivedDataWithRootObject(obj), key: key, timeoutInterval: timeoutInterval)
    }
    

    func cachePathForKey(directory:String,var key:String)->String{
        key = key.stringByReplacingOccurrencesOfString("/", withString: "_")
        return directory.stringByAppendingString(key)
    }
}

