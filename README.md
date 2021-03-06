
# GrandStore

## GrandStore是一个直观且强大的iOS存储库，他用变量名来保存任何类型

## 关键特点
* GrandStore是基于泛型类的,所以它可以存储任何的Object,只要符合了Codable协议
* 可以任意存值和取值
* 强力的缓存特性
* 存储的值是可以被观察的,只要你调用了addObserver函数.
* 清除缓存也相当简单

## 系统要求 

Xcode 8 and iOS 8.0(最新的Swift语法,Swift3)
####请注意,这个类只适用了纯Swift项目,Objc类不能调用这个类
##安装
`如果你使用cocopods, 则pod 'GrandStore' 再安装即可.然后再 pod install`
<br/>
`如果你想使用文件，直接拷贝GrandStore.swift到你的项目即可`
<br>


## 怎么使用
*请参考以下代码 
```swift
 var demoText = GrandStore(name: "DemoText", defaultValue: ""), the second para can not be nil, GrandStore must usr it to infer the type.
```
```swift
demoText.Value = "the value you will set" //set the value
```
```swift
let va = demoText.Value //get the value
```
```swift
let stu = GrandStore(name: "student", defaultValue: Student())// Student is a custom cass and it must confirm NSCoding protocal.The set and get process is the same as the DemoText 
```
```swift
var demoCache = GrandStore(name: "CacheTest", defaultValue: "", timeout: 10)//if you want set a value which can expire,just add the timeout para. cache time 
```
```swift
demoCache..setCacheTime(50)// you can change the cache time anytime, or you can set a current GrandStore to cache mode
```
```swift
demoCache.clear()// call the clear() func to clear the cache
```
```swift
stu.addObserver { (observerObject, observerKey, oldValue, newValue) -> Void in
              self.lblStudent?.text = "old:\(oldValue.debugDescription), new:\(newValue.debugDescription)"
        }
        //if you want to observer the value change, just call the addObserver func, and set the block callback
```
```swift
stu.removeObserver() //call the removeObserver() func to remoce the observer
```
*参考GrandStoreDemo会更好的理解GrandStore怎么使用

<br>

![add -DDEBUG location](https://raw.githubusercontent.com/DuckDeck/GrandStore/master/GrandStoreDemo/Resource/1.png)
<br>

![add -DDEBUG location](https://raw.githubusercontent.com/DuckDeck/GrandStore/master/GrandStoreDemo/Resource/2.png)
<br>

![add -DDEBUG location](https://raw.githubusercontent.com/DuckDeck/GrandStore/master/GrandStoreDemo/Resource/3.png)


## 和我联系
任何问题或者BUG请直接和我联系3421902@qq.com, 我会乐于帮你解决
