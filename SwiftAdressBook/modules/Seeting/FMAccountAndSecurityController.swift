//
//  FMAccountAndSecurityController.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/12/6.
//

import UIKit

class FMAccountAndSecurityController: FMSettingCommonController {

    //var accountList = [FMth]
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "帐号与安全"
    }
    
    override func setupDataSource() {
        
        setupSection0()
        setupSection1()
        setupSection2()
        //self.tableView.reloadData()
        
    }
    
    func setupSection0() {
        var sections = [FMCommonSettingSectionViewModel]()
        var sectionViewModel:FMCommonSettingSectionViewModel
        
        var cells = [FMCommonSettingCellViewModel]()
        var cellModel : FMCommonSettingCellViewModel
        
        cellModel = FMCommonSettingCellViewModel(leftTitle: "手机号", accessoryType: .arrow)
        cellModel.rightText = "137****4212"
        cellModel.selectCallBack = { model in
            print("pushChangePhone")
        }
        cells.append(cellModel)
        
        cellModel = FMCommonSettingCellViewModel(leftTitle: "邮箱", accessoryType: .arrow)
        cellModel.rightText = "tbit_144135@sina.com"
        cellModel.selectCallBack = { model in
            print("pushChangeEmail")
        }
        cells.append(cellModel)
        
        sectionViewModel = FMCommonSettingSectionViewModel(cellViewModels: cells)
        sectionViewModel.sectionFooterHeight = 15
        sections.append(sectionViewModel)
        self.sections.append(contentsOf: sections)

    }
    
    
    func setupSection1() {
        var sections = [FMCommonSettingSectionViewModel]()
        var sectionViewModel:FMCommonSettingSectionViewModel
        
        var cells = [FMCommonSettingCellViewModel]()
        var cellModel : FMCommonSettingCellViewModel
        
        cellModel = FMCommonSettingCellViewModel(leftTitle: "手机号", accessoryType: .arrow)
        cellModel.rightText = "137****4212"
        cellModel.selectCallBack = { model in
            print("pushChangePhone")
        }
        cells.append(cellModel)
        
        cellModel = FMCommonSettingCellViewModel(leftTitle: "邮箱", accessoryType: .arrow)
        cellModel.rightText = "tbit_144135@sina.com"
        cellModel.selectCallBack = { model in
            print("pushChangeEmail")
        }
        cells.append(cellModel)
        
        sectionViewModel = FMCommonSettingSectionViewModel(cellViewModels: cells)
        sectionViewModel.sectionHeaderTitle = "第三方应用"
        sectionViewModel.sectionHeaderTitleFont = .systemFont(ofSize: 12)
        sectionViewModel.sectionHeaderBackgroundColor = .purple
        sectionViewModel.sectionFooterHeight = 35
        sections.append(sectionViewModel)
        
        self.sections.append(contentsOf: sections)
    }
    
    func setupSection2() {
        var sections = [FMCommonSettingSectionViewModel]()
        var sectionViewModel:FMCommonSettingSectionViewModel
        
        var cells = [FMCommonSettingCellViewModel]()
        var cellModel : FMCommonSettingCellViewModel
        
        cellModel = FMCommonSettingCellViewModel(leftTitle: "重置登录密码", accessoryType: .arrow)
        cellModel.selectCallBack = { model in
            print("resetPassword")
        }
        cells.append(cellModel)
        
        
        sectionViewModel = FMCommonSettingSectionViewModel(cellViewModels: cells)
        sections.append(sectionViewModel)
        
        self.sections.append(contentsOf: sections)
    }
}
