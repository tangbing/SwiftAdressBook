//
//  LoginViewController.swift
//  Swift_通讯录
//
//  Created by Tb on 2020/11/7.
//


import UIKit
import Alamofire
import SVProgressHUD
import FCUUID
import YYCategories
import SwiftyJSON

protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue == String {
    static func set(value: String?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func string(forKey key: defaultKeys) -> String? {
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey)
    }
}

class LoginViewController: UIViewController {
    

    let loginURl = "https://apps.epipe.cn/member/v3/user/login/password"
    let APPVERSION = "3.4.4"
    
    var autoToken : String?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let iphone = UserDefaults.AccountInfo.string(forKey: .userMobile)
        guard let userPhone = iphone else {
            return
        }
        
        guard let userPwd = UserDefaults.AccountInfo.string(forKey: .userPwd)  else {
            return
        }
        
        self.nameTextField.text = userPhone
        self.pwdTextField.text = userPwd
    }
    
    @IBAction func login(_ sender: Any)
    {
        var dict : [String : String] = [:]
        
        dict["account"] = self.nameTextField.text
        dict["password"] = self.pwdTextField.text
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        let requestHeader : HTTPHeaders = ["auth_token" : "", "_client" : "ios","imei" : FCUUID.uuidForDevice()! , "ua": String.deviceInfo];
        

        AF.request(loginURl, method: .post, parameters: dict, encoding: URLEncoding.default, headers: requestHeader).responseJSON {[weak self] response in
            SVProgressHUD.dismiss()
            debugPrint(response)
            
            guard let dict = response.value else {
                return}
            let code = JSON(dict)["h"]["code"].intValue
            if code == 200 {
                
                // 保存账号与密码
                UserDefaults.AccountInfo.set(value: self?.nameTextField.text, forKey: .userMobile)
                UserDefaults.AccountInfo.set(value: self?.pwdTextField.text, forKey: .userPwd)
                
                let iphone = UserDefaults.AccountInfo.string(forKey: .userMobile)
                   if let userMobile = iphone {
                       print(userMobile)
                   }
                      
                
                let jsonString = JSON(dict)["b"].dictionaryObject
                guard let user = jsonString?.kj.model(User.self) else {
                    return
                }
                UserDefaults.AccountInfo.set(value: user.authToken, forKey: .userToken)
                SVProgressHUD.showSuccess(withStatus: "登录成功！")
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.dismiss(withDelay: 0.7, completion: {
                self?.navigationController?.pushViewController(AdressBookViewController(), animated: true)
                })

           
            } else if(code == 60) {//新设备登录，请进行安全验证!
                // 保存账号与密码
                UserDefaults.AccountInfo.set(value: self?.nameTextField.text, forKey: .userMobile)
                UserDefaults.AccountInfo.set(value: self?.pwdTextField.text, forKey: .userPwd)
                
//                let check = CheckLogViewController()
//                self?.navigationController!.pushViewController(check, animated: true)
                
            } else {
                let errorMsg = JSON(dict)["h"]["msg"].stringValue
                SVProgressHUD .showError(withStatus: "登录失败！" + errorMsg)
                print("服务器错误！！！")
            }
            
        }
    }
}

extension LoginViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UserDefaults {
    // 账户信息
    struct AccountInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case userMobile
            case userPwd
            case userToken
        }
    }
}


