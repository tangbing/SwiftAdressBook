//
//  SettingViewController.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/12/6.
//

import UIKit
import YYCategories

class FMSettingCommonController: BaseTableViewController {

    var sections = [FMCommonSettingSectionViewModel]()
    
    func setupDataSource() {}
    
    
    func extraConfigCell(_ cell: FMCommonSettingCell, withModel model: FMCommonSettingCellViewModel) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(hexString: "0xF5F5F5")
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        setupDataSource()
    }
}

extension FMSettingCommonController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionViewModel = sections[section]
        return sectionViewModel.cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionViewModel = sections[indexPath.section]
        let cellModel = sectionViewModel.cellViewModels[indexPath.row]
        let cellIdentifier = cellModel.cellIdentifer
        
        var cell: FMCommonSettingCell!

        if let settingCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FMCommonSettingCell {
            cell = settingCell
        } else {
            cell = FMCommonSettingCell(style: .default, reuseIdentifier: cellIdentifier)
        }

        extraConfigCell(cell, withModel: cellModel)
        cell.update(with: cellModel)
        return cell
        
//        if var cell = cel  {
//            cell = FMCommonSettingCell(style: .default, reuseIdentifier: cellIdentifier)
//            extraConfigCell(cell, withModel: cellModel)
//            cell.update(with: cellModel)
//            return cell
//        }
//
//        return UITableViewCell()
       
    }
    
    
}
