//
//  BaseTableViewController.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/12/6.
//

import UIKit

class BaseTableViewController: UITableViewController {
    var showBackButton: Bool = true
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.hidesBottomBarWhenPushed = true
        showBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showBackButton {
            let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back-w"), style: .plain, target: self, action: #selector(goToBack))
            navigationController?.navigationItem.leftBarButtonItem = leftButton
        }
        
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
    }
    
    @objc func goToBack() {
        navigationController?.popViewController(animated: true)
    }

}
