//
//  NetworkTool.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/11/7.
//

import UIKit
import Alamofire
import FCUUID
import SwiftyJSON


typealias successBlock = (_ response: Any) -> Void
typealias failureBlock = (_ error: String) -> Void
typealias NetworkStatus = (_ NetworkStatus: Int32) -> Void
typealias ProgressBlock = (_ progress: Int32) -> Void



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

enum NetworkRequestType {
    case post
    case get
}


class NetworkTool: NSObject {
    
    static let share = NetworkTool()
    private var sessionManager: Session?
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        sessionManager = Session.init(configuration: configuration, delegate: SessionDelegate())
    }
    
    
    func requestWith(url: String,
                     httpMethod: NetworkRequestType,
                     params: [String: Any],
                     success: @escaping  successBlock,
                     failure: @escaping  failureBlock) {
        switch httpMethod {
        case .get:
            loadGetRequest(url, parameters: params, success: success, failure: failure)
        case .post:
            loadPostRequest(url, parameters: params, success: success, failure: failure)
        default:
            break
        }
       
    }
    
    func loadGetRequest(_ loadUrl: String, parameters: [String : Any],
                        success: @escaping  successBlock,
                        failure: @escaping  failureBlock)
    {
        
        let token = UserDefaults.AccountInfo.string(forKey: .userToken) ?? ""
        let requestHeader : HTTPHeaders = ["auth_token" : token, "_client" : "ios","imei" : FCUUID.uuidForDevice()! , "ua": String.deviceInfo];
        
        
        AF.request(Configs.BaseUrl + loadUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: requestHeader).responseJSON { response in
            debugPrint(response)

            switch response.result {
            case .failure:
                let statusCode = response.response?.statusCode
                failure("\(statusCode ?? 0)请求失败")
                break
                   
            case .success:
                //let json = String(data: response.data!, encoding: .utf8)
                guard let dict = response.value else {
                    return}
//                let code = JSON(dict)["h"]["code"].intValue
//                if code == 200 {
//                    let jsonString = JSON(dict)["b"].dictionaryObject
//                    guard let user = jsonString?.kj.model(User.self) else {
//                        return
//                    }
//                    UserDefaults.AccountInfo.set(value: user.authToken, forKey: .userToken)
                    success(dict)
//                } else {
//                    print("请求 error code:\(code)")
//                }
                break
            }
   
        }
    }
    
    func loadPostRequest(_ loadUrl: String, parameters: [String : Any],
                        success: @escaping  successBlock,
                        failure: @escaping  failureBlock)
    {
        
        let token = UserDefaults.AccountInfo.string(forKey: .userToken) ?? ""
        let requestHeader : HTTPHeaders = ["auth_token" : token, "_client" : "ios","imei" : FCUUID.uuidForDevice()! , "ua": String.deviceInfo];
        
        AF.request(Configs.BaseUrl + loadUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: requestHeader).responseJSON { response in
            debugPrint(response)

            switch response.result {
            case .failure:
                let statusCode = response.response?.statusCode
                failure("\(statusCode ?? 0)请求失败")
                break
                   
            case .success:
                //let json = String(data: response.data!, encoding: .utf8)
                guard let dict = response.value else {
                    return}
//                let code = JSON(dict)["h"]["code"].intValue
//                if code == 200 {
//                    let jsonString = JSON(dict)["b"].dictionaryObject
//                    guard let user = jsonString?.kj.model(User.self) else {
//                        return
//                    }
//                    UserDefaults.AccountInfo.set(value: user.authToken, forKey: .userToken)
                    success(dict)
//                } else {
//                    print("请求 error code:\(code)")
//                }
                break
            }
   
        }
    }
    
  
        
}
