//
//  MainTabBarViewController.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/12/6.
//

import UIKit
import RAMAnimatedTabBarController

class MainTabBarViewController: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setupChildVc()
    }
    func setupChildVc() {
        let setting = FMAccountAndSecurityController()
        
        let norImage = UIImage(named: "home-line_1")
        let selectedImage = UIImage(named: "home-mian_1")
        
        let item = RAMAnimatedTabBarItem(title: "设置", image: norImage, selectedImage: selectedImage)
        item.animation = RAMRightRotationAnimation()
        setting.tabBarItem = item;
        let nav1 = UINavigationController(rootViewController: setting)
        
        let adressBook = AdressBookViewController()
        let nor_Image = UIImage(named: "work-line_1")
        let selected_Image = UIImage(named: "work-mian_1")
        let item1 = RAMAnimatedTabBarItem(title: "通讯录", image: nor_Image, selectedImage: selected_Image)
        item1.animation = RAMBounceAnimation()
        adressBook.tabBarItem = item1;
        let nav2 = UINavigationController(rootViewController: adressBook)

        
        let vcs = [nav1, nav2]
        // 这里要重写方法，否则不会有动画
        setViewControllers(vcs, animated: false)
    }


}
