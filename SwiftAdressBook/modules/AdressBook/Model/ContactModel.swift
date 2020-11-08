//
//  ContactModel.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/11/7.
//

import UIKit
import KakaJSON


struct NodeModel {
    var id: String = ""
    var name: String = ""
    var staff: Staffs? = nil
    var children: [Any]? = nil

    func addChild(_ child: Any){
        
    }
    init(nameStr name: String, IdStr id: String, staffsModel staff: Staffs?, childrens children: [Any]?) {
        self.children = children
        self.name = name
        self.staff = staff
        self.id = id
    }
    
}

struct ContactModel : Convertible {
   
    let id: String = ""
    let name: String = ""
    let type: String = ""
    let personNO: String = ""
    let offices: [Offices]? = nil
    
}

struct Offices : Convertible{
    let departID: String = ""
    let name: String = ""
    let personNO: String = ""
    let staff: [Staffs]? = nil
    let subOffice: [Offices]? = nil
}

struct Staffs : Convertible{
    let isCheck: Bool = false
    let userId: String = ""
    let imUserId: String = ""
    let name: String = ""
    let sex: Int = 2
    let mobile: String = ""
    let phone: String = ""
    let address: String = ""
    let profileImg: String = ""
    let companyId: String = ""
    let officeId: String = ""
}

func kj_modelType(from jsonValue: Any?, _ property: Property) -> Convertible.Type? {
    switch property.name {
           case "offices": return Offices.self  // `toys`数组存放`Car`模型
           case "staff": return Staffs.self  // `foods`字典存放`Book`模型
           case "subOffice": return Offices.self  // `foods`字典存放`Book`模型
//           case "pet":
//               if let pet = jsonValue as? [String: Any], let _ = pet["height"] {
//                   // 如果`pet`属性的`jsonValue`是个字典，并且有`height`这个key，就转为`Pig`模型
//                   return Pig.self
//               }
//               // 将`jsonValue`转为`Dog`模型赋值给`pet`属性
//               return Dog.self
           default: return nil
           }
    
}
