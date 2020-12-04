//
//  File.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/11/14.
//

import UIKit

//这里以safeAreaInsets举例建立类似宏定义的东西
   //全局的
   //建一个.swift文件
   //创建常量
   
   //view.safeAreaInsets要在viewDidLoad之后调用才有正确的值，所以可以写一个全局常量，默认lazy属性，延时加载只赋值一次
   //注意，常量只会赋值一次，竖屏调用后，转横屏，再调用值不会变
//var kAppDele: AppDelegate {
//    if let kAppDelegate = UIApplication.shared.delegate as? AppDelegate {
//       return kAppDelegate
//    }
//    return any
//}
    
  
var topSafeAreaInsets : CGFloat {
    if let kAppDelegate = UIApplication.shared.delegate as? AppDelegate {
        let deoubleValu = kAppDelegate.window!.safeAreaInsets.top + 44.0
        return deoubleValu
    }
    return 0
}

var bottomSafeAreaInsets : CGFloat {
    if let kAppDelegate = UIApplication.shared.delegate as? AppDelegate {
        return CGFloat(kAppDelegate.window!.safeAreaInsets.bottom)
    }
    return 0
}

