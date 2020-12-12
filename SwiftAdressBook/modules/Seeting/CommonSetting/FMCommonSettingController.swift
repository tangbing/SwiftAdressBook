//
//  FMCommonSettingController.swift
//  Followme
//
//  Created by Subo on 2018/1/9.
//  Copyright © 2018年 com.followme. All rights reserved.
//

import UIKit

/// 通用设置模块
public class FMCommonSettingController: UITableViewController {
    
    public private(set) var dataSource: [FMCommonSettingSectionViewModel]?

    public override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setupDataSource(dataSource: [FMCommonSettingSectionViewModel]) {
        self.dataSource = dataSource
        tableView.reloadData()
    }

    // MARK: - Table view data source

    public override func numberOfSections(in tableView: UITableView) -> Int {
        if let dataSource = dataSource {
            return dataSource.count
        }
        return 0
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else {
            return 0
        }
        
        let sectionViewModel = dataSource[section]
        return sectionViewModel.cellViewModels.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionViewModel = dataSource![indexPath.section]
        let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
        let identifer = cellViewModel.cellIdentifer
        
        var cell: FMCommonSettingCell!
        if let settingCell = tableView.dequeueReusableCell(withIdentifier: identifer) as? FMCommonSettingCell {
            cell = settingCell
        }else {
            cell = FMCommonSettingCell(style: .default, reuseIdentifier: identifer)
        }
        
        return cell
    }
}
