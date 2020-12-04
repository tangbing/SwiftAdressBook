//
//  CheckLogViewController.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/11/14.
//

import UIKit
import SnapKit

class CheckLogViewController: UIViewController {

    
    lazy var checkButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor(hexString: "#0fc37c")
        btn.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.setTitle("开始验证", for: .normal)
        btn.addTarget(self, action: #selector(check), for: .touchUpInside)
        
        return btn;
    }()
    
    lazy var checkStateImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "verify_log"))
        return img
    }()
    
    lazy var checkMsgLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "你正在一台新设备登录优管App，为了你的账号安全，请进行安全登录"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hexString: "#999999")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账号安全验证"
        setupUI()
    }
    
    override func viewSafeAreaInsetsDidChange () {
           print("top:\(topSafeAreaInsets), bottom:\(bottomSafeAreaInsets)")
       }
       
    
    func setupUI() {
        view.addSubview(self.checkStateImageView)
        view.addSubview(self.checkMsgLabel)
        view.addSubview(self.checkButton)
        
        self.checkStateImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalTo(topSafeAreaInsets + 45)
            make.centerX.equalTo(self.view)
        }
        
        self.checkMsgLabel.snp.makeConstraints { make in
            make.top.equalTo(self.checkStateImageView.snp.bottom).offset(45)
            make.left.equalTo(self.view.snp.left).offset(70)
            make.right.equalTo(self.view.snp.right).offset((-70))
        }
        
        self.checkButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalTo(self.view.snp.left).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.top.equalTo(self.checkMsgLabel.snp.bottom).offset(30)


        }
    }
    
    @objc func check() {
        
    }


}
