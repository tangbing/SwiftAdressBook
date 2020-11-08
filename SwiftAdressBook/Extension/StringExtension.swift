
//
//  StringExtension.swift
//  Demo
//
//  Created by Tb on 2018/8/29.
//  Copyright © 2018年 Tb. All rights reserved.
//

import UIKit

let APPVERSION = "4.2.0"
let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height
let machineModelName = UIDevice.current.machineModelName

extension String {
    static var deviceInfo: String {
        get {
            let phoneVersion   = UIDevice.current.systemVersion;
            return "v=\(APPVERSION)w=\(kWidth)h=\(kHeight)m=\(machineModelName!)os=IOS\(phoneVersion)"
        }
    }
    
//    func UA() -> String {
//
//    }
//
//
}
