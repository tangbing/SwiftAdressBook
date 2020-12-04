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
import HandyJSON


class LoginViewController: UIViewController {
    

    let loginURl = "user/login/password"
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
        var parameter : [String : String] = [:]
        
        parameter["account"] = self.nameTextField.text
        parameter["password"] = self.pwdTextField.text
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        
        NetworkTool.share.loadPostRequest(loginURl, parameters:parameter) { [weak self] response in
            SVProgressHUD.dismiss()
            print(response)
            
            let code = JSON(response)["h"]["code"].intValue
            if code == 200 {
                // 保存账号与密码
                UserDefaults.AccountInfo.set(value: self?.nameTextField.text, forKey: .userMobile)
                UserDefaults.AccountInfo.set(value: self?.pwdTextField.text, forKey: .userPwd)


                let jsonString = JSON(response)["b"].dictionaryObject
                guard let user = jsonString?.kj.model(User.self) else {
                    return}
                
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
    
                    let check = CheckLogViewController()
                    self?.navigationController!.pushViewController(check, animated: true)
    
            }
            
        } failure: { error in
            debugPrint( "login" + error)
        }
        
    }
}

extension LoginViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}




