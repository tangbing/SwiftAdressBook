//
//  FMCommonSettingConfig.swift
//  Followme
//
//  Created by Subo on 2018/1/9.
//  Copyright © 2018年 com.followme. All rights reserved.
//

import UIKit

/// 通用设置配置类
public class FMCommonSettingConfig: NSObject {
    //section
    public var sectionHeaderHeight: CGFloat = 15
    public var sectionHeaderLeftSpace: CGFloat = 15
    public var sectionHeaderTopSpace: CGFloat = 15
    public var sectionHeaderBackgroundColor = UIColor.clear
    public var sectionHeaderTitleFont = UIFont.systemFont(ofSize: 17)
    public var sectionHeaderTitleColor: UIColor = .lightGray
    
    public var sectionFooterHeight: CGFloat = 0
    
    //cell
    public var cellHeight: CGFloat = 48
    public var accessoryArrowImage: UIImage? = #imageLiteral(resourceName: "im_noselectfile_icon")
    public var cellSeparatorStyle: FMCommonSettingCellSeparatorStyle = .none
    public var cellSeparatorHeight: CGFloat = 0.5
    
    public var cellLeftSpace: CGFloat = 15
    public var cellRightSpace: CGFloat = 15
    /// 左边元素之间的间隙
    public var cellSpaceBetweenLeftItems: CGFloat = 8
    /// 右边元素之间的间隙
    public var cellSpaceBetweenRightItems: CGFloat = 8
    
    public var cellLeftTitleFont: UIFont = .systemFont(ofSize: 15)
    public var cellLeftTitleColor: UIColor = .lightGray
    public var cellRightTextFont: UIFont = .systemFont(ofSize: 13)
    public var cellRightTextColor: UIColor = .red
    
    public var cellRightButtonTitleFont: UIFont = .systemFont(ofSize: 12)
    public var cellRightButtonTitleColor: UIColor = .orange
    public var cellRightButtonSize: CGSize = CGSize(width: 55, height: 24)
    
    /// 单例
    public static let `default` = FMCommonSettingConfig()
}
