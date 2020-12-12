//
//  FMCommonSettingSectionViewModel.swift
//  Followme
//
//  Created by Subo on 2018/1/9.
//  Copyright © 2018年 com.followme. All rights reserved.
//

import UIKit

@objc public class FMCommonSettingSectionViewModel: NSObject {
    
    @objc public var sectionHeaderTitle: String?
    
    @objc public var sectionHeaderHeight: CGFloat = FMCommonSettingConfig.default.sectionHeaderHeight
    @objc public var sectionHeaderLeftSpace: CGFloat = FMCommonSettingConfig.default.sectionHeaderLeftSpace
    @objc public var sectionHeaderBackgroundColor: UIColor = FMCommonSettingConfig.default.sectionHeaderBackgroundColor
    @objc public var sectionHeaderTitleFont: UIFont = FMCommonSettingConfig.default.sectionHeaderTitleFont
    @objc public var sectionHeaderTitleColor: UIColor = FMCommonSettingConfig.default.sectionHeaderTitleColor
    
    @objc public var sectionFooterHeight: CGFloat = FMCommonSettingConfig.default.sectionFooterHeight
    
    @objc public var cellViewModels: [FMCommonSettingCellViewModel]
    
    @objc init(cellViewModels: [FMCommonSettingCellViewModel]) {
        self.cellViewModels = cellViewModels
    }

}
