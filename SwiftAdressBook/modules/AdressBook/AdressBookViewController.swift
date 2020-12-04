//
//  AdressBookViewController.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/11/7.
//

import UIKit
import Alamofire
import SVProgressHUD
import FCUUID
import SwiftyJSON
import KakaJSON
import RATreeView
import DZNEmptyDataSet
import YYCategories

//extension UIView {
//    var right: CGFloat {
//        return self.frame.origin.x + self.frame.size.width
//    }
//}

enum imageShowType: Int {
    case profileImgType = 0, arrowType
}


class AdressBookViewController: UIViewController {
  
    static let StaffCellIdentifier  = "StaffCellIdentifier"
    var iconShowType  = imageShowType.arrowType
    
    
    final var addressUrl = "organ/addressbook"
    
    
    lazy var contentModels = [ContactModel]()
    lazy var dataSourceArray = [NodeModel]()
    lazy var treeView: RATreeView = {
        let iv = RATreeView(frame: self.view.bounds)
        iv.treeFooterView = UIView()
        iv.delegate = self
        iv.dataSource = self
        iv.scrollView.emptyDataSetSource = self
        iv.scrollView.emptyDataSetDelegate = self
        iv.register(ContactCell.self, forCellReuseIdentifier: Self.StaffCellIdentifier)
//        iv.register(UINib(nibName: , bundle: nil), forCellReuseIdentifier: Self.StaffCellIdentifier)
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "通讯录"
        view.backgroundColor = .white
        loadData()
        setupUI()
        
    }
    
    func setupUI() {
        self.view.addSubview(self.treeView)
    }
    
    func loadData() {
        
        guard let _ = UserDefaults.AccountInfo.string(forKey: .userToken)  else {
            return
        }
        
        NetworkTool.share.loadGetRequest(addressUrl, parameters: ["showGroup" : true]) {[weak self] response in
            SVProgressHUD.dismiss()
            //debugPrint(response)
            
            let code = JSON(response)["h"]["code"].intValue
            if code == 200 {
                let jsonString = JSON(response)["b"].dictionaryObject
                guard let dataString = jsonString?["data"] else {return}

                guard let json = dataString as? [[String : Any]] else{
                    print("json为空")
                    return}

                //print("resultJson:\(json)")
                let models = json.kj.modelArray(type: ContactModel.self) as! [ContactModel]
                print(models)
                self?.contentModels.removeAll()
                self?.contentModels.append(contentsOf: models)

                self?.contentModels.forEach{
                    let array = self?.handelOffices($0.offices!)
                    let node = NodeModel(nameStr: $0.name, IdStr: $0.id, staffsModel: nil, childrens: array)
                    self?.dataSourceArray.append(node)
                }

                self?.treeView.reloadData()

            } else {
                print("请求失败！")
            }
            
        } failure: { errorStr in
            debugPrint("请求失败！" + errorStr)
        }

//        AF.request(addressUrl, method: .get, parameters: ["showGroup" : true], encoding: URLEncoding.default, headers: requestHeader).responseJSON {[weak self] response in
//            SVProgressHUD.dismiss()
//            debugPrint(response)
//
//            guard let dict = response.value else {
//                return}
//            let code = JSON(dict)["h"]["code"].intValue
//            if code == 200 {
//                let jsonString = JSON(dict)["b"].dictionaryObject
//                guard let dataString = jsonString?["data"] else {return}
//
//                guard let json = dataString as? [[String : Any]] else{
//                    print("json为空")
//                    return}
//
//                print("resultJson:\(json)")
//                let models = json.kj.modelArray(type: ContactModel.self) as! [ContactModel]
//                print(models)
//                self?.contentModels.removeAll()
//                self?.contentModels.append(contentsOf: models)
//                print(self?.contentModels ?? nil)
//
//                self?.contentModels.forEach{
//                    let array = self?.handelOffices($0.offices!)
//                    let node = NodeModel(nameStr: $0.name, IdStr: $0.id, staffsModel: nil, childrens: array)
//                    self?.dataSourceArray.append(node)
//                }
//
//                self?.treeView.reloadData()
//
//            } else {
//                print("请求失败！")
//            }
//        }
    }
    
    private func handelOffices(_ officeModelsArray: [Offices]) -> [NodeModel] {
        var resultArray = [NodeModel]()
        
        officeModelsArray.forEach {
            let node: NodeModel = self.dealStaffs($0)
            if let suboffice = $0.subOffice {
                let subOfficeArray = handelOffices(suboffice)
                subOfficeArray.forEach {
                    node.addChild($0)
                }
            }
            resultArray.append(node)
        }
        return resultArray
    }
    
    private func dealStaffs(_ officeModel: Offices) -> NodeModel {
        var models = [NodeModel]()
        officeModel.staff?.forEach {
            let node = NodeModel(nameStr: $0.name, IdStr: $0.userId, staffsModel: $0, childrens: nil)
            models.append(node)
        }
        return NodeModel(nameStr: officeModel.name, IdStr: officeModel.departID, staffsModel: nil, childrens: models)
    }
    private func getArrowImge(_ treeView: RATreeView,willCollapseRowForItem item: Any ) -> UIImageView {
        let cell = treeView.cell(forItem: item) as! ContactCell
        var clickImage: UIImageView = UIImageView()
        for iv in cell.contentView.subviews {
            if iv is UIImageView {
                clickImage = iv as! UIImageView
                break
            }
        }
        return clickImage
    }
}

// MARK: RATreeViewDelegate
extension AdressBookViewController : RATreeViewDataSource {
    func treeView(_ treeView: RATreeView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return self.dataSourceArray.count
        }
        let node = item as! NodeModel
        return node.children?.count ?? 0
    }
    
    func treeView(_ treeView: RATreeView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return self.dataSourceArray[index]
        }
        let node = item as! NodeModel
        return (node.children?[index]) as Any
    }
    
    
    func treeView(_ treeView: RATreeView, cellForItem item: Any?) -> UITableViewCell {
        let level = treeView.levelForCell(forItem: item as Any)
        
        guard let dataModel = item as? NodeModel else {
            print("dataModel 为空")
            return UITableViewCell()
        }
        
        let cell = treeView.dequeueReusableCell(withIdentifier: Self.StaffCellIdentifier) as! ContactCell
        if dataModel.staff == nil {
            cell.headImageView.image = UIImage(named: "contact_shouqi")
            cell.nameLab.text = dataModel.name
            cell.updateSubViewFrame(leaveInt: level, showType: .arrowType)

        } else {
            cell.staffModel = dataModel.staff!
            cell.updateSubViewFrame(leaveInt: level, showType: .profileImgType)
        }
        return cell
    }

}

extension AdressBookViewController : RATreeViewDelegate {
    func treeView(_ treeView: RATreeView, heightForRowForItem item: Any) -> CGFloat {
        return 50
    }
    func treeView(_ treeView: RATreeView, willExpandRowForItem item: Any) {
        guard let dataModel = item as? NodeModel else {
            print("dataModel 为空")
            return
        }
        /*
         forEach循环 没有break
         forEach is not a loop (it is a block passed to a loop, but not a loop itself), or more accurately, forEach is not part of Swift's Control Flow. Which is why you can't use break or continue.
         更准确地说，forEach不是循环（它是传递到循环的块，但不是循环本身）
         forEach不是Swift的控制流的一部分。这就是为什么您不能使用break或Continue的原因。
         

         Variable 'clickImage' captured by a closure before being initialized
         You need to initialize the variable before use it inside a closure:

         As per apple documentation

         If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit self property, or call any of the instance’s methods.
         */
        if dataModel.staff == nil {
            let clickImage = getArrowImge(treeView, willCollapseRowForItem: item)
            UIView.animate(withDuration: 0.25) {
                clickImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 0.5
                )
            }
        }
    }
    
    func treeView(_ treeView: RATreeView, willCollapseRowForItem item: Any) {
        guard let dataModel = item as? NodeModel else {
            print("dataModel 为空")
            return
        }
        if dataModel.staff == nil {
            let clickImage = getArrowImge(treeView, willCollapseRowForItem: item)
            UIView.animate(withDuration: 0.25) {
                clickImage.transform = CGAffineTransform.identity
            }
        }
    }
    
        
}

// MARK: EmptyScrollViewDelegate
extension AdressBookViewController : DZNEmptyDataSetSource {
   
    
    
}

extension AdressBookViewController : DZNEmptyDataSetDelegate {
   
    
    
}
