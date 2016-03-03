//
//  GrandStore.swift
//  GrandStoreDemo
//
//  Created by Tyrant on 1/6/16.
//  Copyright © 2016 Qfq. All rights reserved.
//

import Foundation

public class GrandStore<T> {
    private var name:String!
    private var value:T?
    private var defaultValue:T?
    private var hasValue:Bool = false
    private var timeout:Int = 0
    private var storeLevel:Int = 0
    private var isTemp = false//只是放到内存里临时保存
    private var timeoutDate:NSDate?
    private var observerBlock:((observerObject:AnyObject,observerKey:String,oldValue:AnyObject,newValue:AnyObject)->Void)?
   public  init(name:String,defaultValue:T) {
        self.name = name;
        self.defaultValue = defaultValue;
        storeLevel = self.getStoreLevel()
        //GrandStore.sharedStore.setObject(self, forKey: self.name)
    }
    

    
  public  init(name:String,defaultValue:T,timeout:Int) {  //一般这两个就够了
        self.name = name;
        self.defaultValue = defaultValue;
        self.timeout = timeout
        if self.timeout > 0{
            timeoutDate = NSDate(timeIntervalSinceNow: Double(self.timeout))
        }
        else{
            isTemp = true
        }
        storeLevel = self.getStoreLevel()
        //GrandStore.sharedStore.setObject(self, forKey: self.name)
    }
    
    
    
  public  var Value:T?
        {
        get
        {
            if isExpire{
                self.clear()
                hasValue = false
            }
            if !hasValue
            {
                if isTemp{
                    if self.value == nil{
                        self.value = defaultValue
                        hasValue = true
                    }
                }
                else{
                if storeLevel == 0 //如果存储等级为0,那么从userdefault取
                {
                    if GrandStore.settingData().objectForKey(name) == nil //如果取不出来
                    {
                        self.value = self.defaultValue;
                        GrandStore.settingData().setObject(self.value! as? AnyObject, forKey: self.name)
                        GrandStore.settingData().synchronize()
                        hasValue = true
                    }
                    else
                    {
                        self.value = GrandStore.settingData().objectForKey(self.name) as? T
                        hasValue = true
                    }
                }
                if storeLevel == 1 //这是用归档保存, 日后处理
                {
                    if !GrandCache.globleCache.hasCacheForKey(self.name){
                        self.value = self.defaultValue
                        if timeoutDate != nil{
                            if self.value is NSCoding{
                                GrandCache.globleCache.setObject(self.value as! NSCoding, key: self.name, timeoutInterval: Double(self.timeout))
                                timeoutDate = NSDate(timeIntervalSinceNow: Double(self.timeout))
                            }
                            else{
                                assert(true, "if you want to store the complex  value, you must let it abide by NSCoding protocal")
                            }
                        }
                        else{
                            if self.value is NSCoding{
                                GrandCache.globleCache.setObject(self.value as! NSCoding, key: self.name)
                            }
                            else{
                                assert(true, "if you want to store the complex  value, you must let it abide by NSCoding protocal")
                            }
                        }
                        hasValue = true
                    }
                    else{
                        self.value = GrandCache.globleCache.objectForKey(self.name) as? T
                        hasValue = true
                    }
                }
                }
            }
            return self.value
        }
        set
        {
//            GrandStoreSetting.sharedObserverKey.enumerateObjectsUsingBlock { (obj, idx, stop) -> Void in
//                if obj.isEqualToString(self.name){
                    if let call = self.observerBlock{
                        if self.value == nil
                        {
                            self.value = self.defaultValue
                        }
                        call(observerObject: self,observerKey: self.name,oldValue: self.value as! AnyObject,newValue: newValue as! AnyObject)
                    }
//                }
//            }
            self.value = newValue
            if isTemp{
                hasValue = true
            }
            else{
             if storeLevel == 0
            {
                GrandStore.settingData().setObject(self.value! as? AnyObject, forKey: self.name)
                GrandStore.settingData().synchronize()
                if timeoutDate != nil{
                    timeoutDate = NSDate(timeIntervalSinceNow: Double(self.timeout))
                }
            }
            if storeLevel == 1  //这是用归档保存, 日后处理
            {
                if timeoutDate != nil{
                    if self.value is NSCoding{
                        GrandCache.globleCache.setObject(self.value as! NSCoding, key: self.name, timeoutInterval: Double(self.timeout))
                        timeoutDate = NSDate(timeIntervalSinceNow: Double(self.timeout))
                    }
                    else{
                        assert(true, "if you want to store the complex  value, you must let it abide by NSCoding protocal")
                    }
                }
                else{
                    if self.value is NSCoding{
                        GrandCache.globleCache.setObject(self.value as! NSCoding, key: self.name)
                        // timeoutDate = NSDate(timeIntervalSinceNow: Double(self.timeout))
                    }
                    else{
                        assert(true, "if you want to store the complex  value, you must let it abide by NSCoding protocal")
                    }
                }
                }
            }
            hasValue = true
        }
    }
    
    private var isExpire:Bool{
        get{
            if timeoutDate == nil{
                return false
            }
            else{
                return NSDate().compare(timeoutDate!) == NSComparisonResult.OrderedDescending
            }
        }
    }
    
  public  var wilfulValue:T?{
        return value
    }
    
    func setCacheTime(cacheTime:Int){
        self.timeout = cacheTime
        if self.timeout > 0{
            timeoutDate = NSDate(timeIntervalSinceNow: Double(self.timeout))
        }
    }
    
    public func clear(){
//        GrandStoreSetting.sharedObserverKey.enumerateObjectsUsingBlock { (obj, idx, stop) -> Void in
//            if obj.isEqualToString(self.name){
            if let call = self.observerBlock{
                call(observerObject: self,observerKey: self.name,oldValue: self.value as! AnyObject,newValue: self.defaultValue as! AnyObject)
            }
//            }
//        }
        GrandStore.settingData().removeObjectForKey(self.name)
        GrandCache.globleCache.removeCacheForKey(self.name)
        hasValue = false
    }
    
    
  public  func addObserver(block:(observerObject:AnyObject,observerKey:String,oldValue:AnyObject,newValue:AnyObject)->Void){
        //GrandStoreSetting.sharedObserverKey.addObject(self.name)
        self.observerBlock = block
    }
  public  func removeObserver(){
       // GrandStoreSetting.sharedObserverKey.removeObject(self.name)
        self.observerBlock = nil
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
    //在Swift中,当需要把一个类转为泛型类时,Swift必需知道这个泛型类是个什么样的类,不然就不行,现在Swift又没有KVC和KVO,所以很多OBJC的功能目前实现不了,以后看有没有机会实现
}

//class GrandStoreSetting {
//    private static let sharedStoreInstance = NSMutableDictionary()
//    class var sharedStore:NSMutableDictionary {
//        return sharedStoreInstance
//    }
//    private static let sharedObserverKeyInstance = NSMutableArray()
//    class var  sharedObserverKey:NSMutableArray{
//        return sharedObserverKeyInstance
//    }
//    static func clearAllCache(){
//        GrandStore.sharedStore.enumerateKeysAndObjectsUsingBlock { (obj, idx, stop) -> Void in
//            obj.clear()
//        }
//    }
//    static  func clearCacheWithNames(names:[String]){
//        GrandStore.sharedStore.enumerateKeysAndObjectsUsingBlock { (obj, idx, stop) -> Void in
//            if names.contains(obj.name){
//                obj.clear()
//            }
//        }
//    }
//    static func clearCacheExceptNames(names:[String]){
//        GrandStore.sharedStore.enumerateKeysAndObjectsUsingBlock { (obj, idx, stop) -> Void in
//            if !names.contains(obj.name){
//                obj.clear()
//            }
//        }
//    }
//    
//    static func clearCache(){
//        GrandStore.sharedStore.enumerateKeysAndObjectsUsingBlock { (obj, idx, stop) -> Void in
//            //            if let store = obj as? G_S{
//            //                if store.timeoutDate != nil{
//            //                    store.clear()
//            //                }
//            //            }
//            //没办法,只有用KVC了
//            //            if let _ = obj.valueForKey("timeoutDate") as? NSDate{
//            //
//            //            }
//            //            else{
//            //                obj.clear()
//            //            }
//            //swift 里面没有KVC
//            
//        }
//    }
    //    static  func getValueWithName(name:String)->AnyObject?{
    //        if let gs = GrandStore.sharedStore.objectForKey(name) as? G_S{
    //            return gs.Value as? AnyObject
    //        }
    //        else{
    //            return nil;
    //        }
    //    }
    //    static  func setValueWithName(name:String,value:AnyObject){
    //        if let gs = GrandStore.sharedStore.objectForKey(name) as? G_S{
    //            gs.Value = value as? T
    //        }
    //    }
    
//}
//在Swift目前的机制下,这个类没什么用


class GrandCache {
    // Now turn EGOCahce to swift laguage
    private static let sharedInstance = GrandCache()
    class  var globleCache:GrandCache {
        return sharedInstance
    }
    
    var cacheInfoQueue:dispatch_queue_t
    var frozenCacheInfoQueue:dispatch_queue_t
    var diskQueue:dispatch_queue_t
    var cacheInfo:[String:NSDate]
    var directory:String
    var needSave:Bool = false
    var frozenCacheInfo:[String:NSDate]
    var defaultTimeoutInterval:NSTimeInterval = Double(Int.max)
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