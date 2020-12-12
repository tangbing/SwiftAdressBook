//
//  FMCommonSettingItemModel.swift
//  Followme
//
//  Created by Subo on 2018/1/9.
//  Copyright © 2018年 com.followme. All rights reserved.
//

import UIKit
import CoreGraphics

@objc public enum FMCommonSettingAccessoryType: Int {
    case none
    case switchControl
    case arrow
}

@objc public enum FMCommonSettingCellSeparatorStyle: Int {
    case none
    case full
    case alignLeft
}

@objc public enum FMCommonSettingRightImagePosition: Int {
    case none
    case left
    case right
}

@objc public class FMCommonSettingCellViewModel: NSObject {
    
    @objc public var heigh = FMCommonSettingConfig.default.cellHeight
    @objc public var separatorStyle: FMCommonSettingCellSeparatorStyle = FMCommonSettingConfig.default.cellSeparatorStyle
    @objc public var separatorHeight: CGFloat = FMCommonSettingConfig.default.cellSeparatorHeight
    
    /// cell的唯一ID
    @objc public var cellId: NSInteger = 0
    
    //Left
    @objc public var leftImage: UIImage?
    public var leftImageSize: CGSize?
    @objc public var leftTitle: String?
    @objc public var leftTitleFont: UIFont = FMCommonSettingConfig.default.cellLeftTitleFont
    @objc public var leftTitleColor: UIColor = FMCommonSettingConfig.default.cellLeftTitleColor
    @objc public var leftSpace: CGFloat = FMCommonSettingConfig.default.cellLeftSpace
    @objc public var spaceBetweenLeftItems = FMCommonSettingConfig.default.cellSpaceBetweenLeftItems
    
    //right
    @objc public var rightSpace: CGFloat = FMCommonSettingConfig.default.cellRightSpace
    @objc public var accessoryType: FMCommonSettingAccessoryType = .none
    @objc public var accessoryArrowImage: UIImage? = FMCommonSettingConfig.default.accessoryArrowImage
    @objc public var rightImagePosition: FMCommonSettingRightImagePosition = .none
    @objc public var rightImage: UIImage?
    @objc public var rightImageSize: CGSize = .zero
    @objc public var rightText: String?
    @objc public var rightButtonTitle: String?
    @objc public var rightButtonTitleFont: UIFont = FMCommonSettingConfig.default.cellRightButtonTitleFont
    @objc public var rightButtonTitleColor: UIColor = FMCommonSettingConfig.default.cellRightButtonTitleColor
    @objc public var rightButtonSize: CGSize = FMCommonSettingConfig.default.cellRightButtonSize

    @objc public var rightTextColor: UIColor = FMCommonSettingConfig.default.cellRightTextColor
    @objc public var rightTextFont: UIFont = FMCommonSettingConfig.default.cellRightTextFont
    @objc public var spaceBetweenRightItems = FMCommonSettingConfig.default.cellSpaceBetweenRightItems
    
    /// 跳转的Conroller名称，适合不需要传参的情况
    @objc public var destination: String?
    /// 关联某个对象，用于其他额外值的存储
    @objc public var associatedObject: AnyObject?
    
    @objc public init(leftTitle: String, accessoryType: FMCommonSettingAccessoryType = .none ) {
        self.leftTitle = leftTitle
        self.accessoryType = accessoryType
        super.init()
    }
    
    //callback
    
    /// switch开关回调
    @objc public var switchValueChanged: ((Bool) -> Void)?
    /// 选择回调
    @objc public var selectCallBack:((FMCommonSettingCellViewModel) -> Void)?
    
    /// RightButton回调
    @objc public var rightButtonDidClickCallBack:((FMCommonSettingCellViewModel) -> Void)?
    
    @objc public var isLeftHasImage: Bool {
        return leftImage != nil
    }
    
    @objc public var isLeftHasTitle: Bool {
        return leftTitle != nil
    }
    
    /// 右边部分是否包含图片
    @objc public var isRightHasImage: Bool {
        return rightImagePosition != .none
    }
    
    /// 右边部分是否包含文字
    @objc public var isRightHasText: Bool {
        return rightText != nil
    }
    
    @objc public var hasAccessoryArrow: Bool {
        return accessoryType == .arrow
    }
    
    @objc public var hasSwitch: Bool {
        return accessoryType == .switchControl
    }
    
    @objc public  var hasRightButton: Bool {
        return rightButtonTitle != nil
    }
    
//    public var is
    
    /// cell reuser identifier
    @objc public var cellIdentifer: String {
        

        var identifer = ""
        if isLeftHasImage {
            let ketyPath = \FMCommonSettingCellViewModel.isLeftHasImage
            identifer += ketyPath.stringValue
            identifer += "_"
        }
        if isLeftHasTitle {
            let ketyPath = \FMCommonSettingCellViewModel.isLeftHasTitle
            identifer += ketyPath.stringValue
            identifer += "_"
        }
        if isRightHasText {
            let ketyPath = \FMCommonSettingCellViewModel.isRightHasText
            identifer += ketyPath.stringValue
            identifer += "_"
        }
        if isRightHasImage {
            let ketyPath = \FMCommonSettingCellViewModel.isRightHasImage
            identifer += ketyPath.stringValue
            identifer += "_"
        }
        if hasAccessoryArrow {
            let ketyPath = \FMCommonSettingCellViewModel.hasAccessoryArrow
            identifer += ketyPath.stringValue
            identifer += "_"
        }else if hasSwitch {
            let ketyPath = \FMCommonSettingCellViewModel.hasSwitch
            identifer += ketyPath.stringValue
            identifer += "_"
        }
        
        return ""
    }
    
    
}

extension PartialKeyPath where Root == FMCommonSettingCellViewModel {
    
  
    var stringValue: String {
        switch self {
        case \FMCommonSettingCellViewModel.isLeftHasImage: return "isLeftHasImage"
        case \FMCommonSettingCellViewModel.isLeftHasTitle: return "isLeftHasTitle"
        case \FMCommonSettingCellViewModel.isRightHasImage: return "isRightHasImage"
        case \FMCommonSettingCellViewModel.isRightHasText: return "isRightHasText"
        case \FMCommonSettingCellViewModel.hasAccessoryArrow: return "hasAccessoryArrow"
        case \FMCommonSettingCellViewModel.hasSwitch: return "hasSwitch"
        default: fatalError("Unexpected key path")
        }
    }
}
