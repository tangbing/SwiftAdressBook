//
//  NetworkTool.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/11/7.
//

import UIKit
import Alamofire


typealias successBlock = (() -> Void)?
typealias failureBlock = (() -> Void)?


class NetworkTool: NSObject {
    static let share = NetworkTool()
    
    
    func loadGetRequest(_ loadUrl: String, parameters: [String : Any]) {
        
        AF.request(Configs.BaseUrl + loadUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] response in
            debugPrint(response)
            guard let dict = response.value else {
                return}
            
        }
    }
}
