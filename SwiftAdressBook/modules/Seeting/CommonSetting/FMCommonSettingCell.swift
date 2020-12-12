//
//  FMCommonSettingCell.swift
//  Followme
//
//  Created by Subo on 2018/1/9.
//  Copyright © 2018年 com.followme. All rights reserved.
//

import UIKit
import Masonry

@objcMembers class FMCommonSettingCell: UITableViewCell {

    private lazy var leftView: UIView = {
        let leftView = UIView()
        return leftView
    }()
    
    public private(set) lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public private(set) lazy var leftTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    public private(set) lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
//        label.preferredMaxLayoutWidth = FMScreenScaleFrom(200)
        label.setContentCompressionResistancePriority(UILayoutPriority(249), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    public private(set) lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public private(set) lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.addTarget(self, action: #selector(changeState(_:)), for: .valueChanged)
        return switchControl
    }()
    public private(set) var accessoryArrowImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public private(set) lazy var rightButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(rightButtonDidClick(_:)), for: .touchUpInside)
        return button
    }()
    
    override func prepareForReuse() {
        contentView.removeAllSubviews()
    }
    
    @objc private func changeState(_ sender: UISwitch) {
        guard let viewModel = viewModel, viewModel.switchValueChanged != nil else {
            return
        }
        
        viewModel.switchValueChanged!(sender.isOn)
    }
    
    @objc private func rightButtonDidClick(_ sender: UIButton) {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.rightButtonDidClickCallBack?(viewModel);
    }
    
    private var viewModel: FMCommonSettingCellViewModel?
    
    override func updateConstraints() {
        super.updateConstraints()
        
        guard let viewModel = viewModel else {
            return
        }
        
        if hasLeftView() {
            leftView.mas_makeConstraints({ make in
                make?.left.equalTo()(contentView)?.offset()(viewModel.leftSpace)
                make?.top.bottom().equalTo()(contentView)
            })
        }
        
        if viewModel.isLeftHasImage {
            leftImageView.mas_makeConstraints({ make in
                make?.left.equalTo()(leftView)
                make?.centerY.equalTo()(leftView)
                if let imageSize = viewModel.leftImageSize {
                    make?.size.mas_equalTo()(imageSize)
                }
                if !viewModel.isLeftHasTitle {
                    make?.right.equalTo()(leftView)
                }
            })
        }
        if viewModel.isLeftHasTitle {
            leftTitleLabel.mas_makeConstraints({ make in
                if viewModel.isLeftHasImage {
                    make?.left.equalTo()(leftImageView.mas_right)?.offset()(viewModel.spaceBetweenLeftItems)
                }else {
                    make?.left.equalTo()(leftView)
                }
                make?.centerY.right().equalTo()(leftView)
            })
        }
        
        if viewModel.hasAccessoryArrow {
            accessoryArrowImageView.mas_makeConstraints({ (make) in
                make?.right.equalTo()(contentView)?.offset()(-viewModel.rightSpace)
                make?.centerY.equalTo()(contentView)
            })
        }else if viewModel.hasSwitch {
            switchControl.mas_makeConstraints({ (make) in
                make?.right.equalTo()(contentView)?.offset()(-viewModel.rightSpace)
                make?.centerY.equalTo()(contentView)
            })
        }
        
        if viewModel.isRightHasText && viewModel.isRightHasImage {
            if viewModel.rightImagePosition == .left {
                updateConstraints(for: rightTextLabel, viewModel: viewModel)
                rightImageView.mas_makeConstraints({ (make) in
                    make?.centerY.equalTo()(contentView)
                    make?.right.equalTo()(rightTextLabel.mas_left)?.offset()(-viewModel.spaceBetweenRightItems)
                })
            }else {
                updateConstraints(for: rightImageView, viewModel: viewModel)
                rightTextLabel.mas_makeConstraints({ (make) in
                    make?.centerY.equalTo()(contentView)
                    make?.right.equalTo()(rightImageView.mas_left)?.offset()(-viewModel.spaceBetweenRightItems)
                })
            }
            
            if viewModel.rightImageSize != .zero {
                rightImageView.mas_makeConstraints({ (make) in
                    make?.size.mas_equalTo()(viewModel.rightImageSize)
                })
            }
        }else if viewModel.isRightHasText {
            updateConstraints(for: rightTextLabel, viewModel: viewModel)
        }else if viewModel.isRightHasImage {
            updateConstraints(for: rightImageView, viewModel: viewModel)
            if viewModel.rightImageSize != .zero {
                rightImageView.mas_makeConstraints({ (make) in
                    make?.size.mas_equalTo()(viewModel.rightImageSize)
                })
            }
        } else if viewModel.hasRightButton {
            rightButton.mas_makeConstraints { (make) in
                make?.right.equalTo()(contentView)?.offset()(-viewModel.rightSpace)
                make?.centerY.equalTo()(contentView)
                make?.size.equalTo()(viewModel.rightButtonSize)
            }
        }
    }
    
    func updateConstraints(for view: UIView, viewModel: FMCommonSettingCellViewModel) {
        view.mas_makeConstraints({ (make) in
            make?.left.greaterThanOrEqualTo()(hasLeftView() ? leftView.mas_right : contentView )?.offset()(20)
            make?.centerY.equalTo()(contentView)
            if viewModel.hasAccessoryArrow {
                make?.right.equalTo()(accessoryArrowImageView.mas_left)?.offset()(-viewModel.spaceBetweenRightItems)
            }else if viewModel.hasSwitch {
                make?.right.equalTo()(switchControl.mas_left)?.offset()(-viewModel.spaceBetweenRightItems)
            }else if viewModel.hasRightButton {
                make?.right.equalTo()(rightButton.mas_left)?.offset()(-viewModel.spaceBetweenRightItems)
            } else {
                make?.right.equalTo()(contentView)?.offset()(-viewModel.rightSpace)
            }
        })
    }
    
    @objc func update(with viewModel: FMCommonSettingCellViewModel) {
        self.viewModel = viewModel
        
        if hasLeftView() {
            contentView.addSubview(leftView)
        }
        
        if viewModel.isLeftHasImage {
            leftView.addSubview(leftImageView)
            leftImageView.image = viewModel.leftImage
        }
        if viewModel.isLeftHasTitle {
            leftView.addSubview(leftTitleLabel)
            leftTitleLabel.font = viewModel.leftTitleFont
            leftTitleLabel.textColor = viewModel.leftTitleColor
            leftTitleLabel.text = viewModel.leftTitle
        }
        if viewModel.hasAccessoryArrow {
            contentView.addSubview(accessoryArrowImageView)
            accessoryArrowImageView.image = viewModel.accessoryArrowImage
        }
        if viewModel.isRightHasText {
            contentView.addSubview(rightTextLabel)
            rightTextLabel.font = viewModel.rightTextFont
            rightTextLabel.textColor = viewModel.rightTextColor
            rightTextLabel.text = viewModel.rightText
        }
        if viewModel.isRightHasImage {
            contentView.addSubview(rightImageView)
        }
        if viewModel.hasSwitch {
            contentView.addSubview(switchControl)
        }
        
        if viewModel.hasRightButton {
            contentView.addSubview(rightButton)
            rightButton.titleLabel?.font = viewModel.rightButtonTitleFont
            rightButton.setTitleColor(viewModel.rightButtonTitleColor, for: .normal)
            rightButton.layer.borderColor = viewModel.rightButtonTitleColor.cgColor
            rightButton.setTitle(viewModel.rightButtonTitle, for: .normal)
        }
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        setNeedsLayout()
    }
    
    private func hasLeftView() -> Bool {
        if viewModel == nil {
            return false
        }
        
        return viewModel!.isLeftHasImage || viewModel!.isLeftHasTitle
    }
}
