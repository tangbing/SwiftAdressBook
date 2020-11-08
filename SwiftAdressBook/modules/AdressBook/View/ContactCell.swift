//
//  ContactCell.swift
//  SwiftAdressBook
//
//  Created by Tb on 2020/11/7.
//

import UIKit
import YYCategories
import Kingfisher

class ContactCell: UITableViewCell {

    lazy var headImageView: UIImageView = {
        let iv = UIImageView()

        return iv
    }()
    
    lazy var nameLab: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(hexString: "#333333")
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .left
        return lb
    }()
    var staffModel: Staffs = Staffs() {
        didSet {
            self.headImageView.kf.setImage(with: URL(string: staffModel.profileImg))
            self.nameLab.text = staffModel.name;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func updateSubViewFrame(leaveInt level: Int, showType: imageShowType) {
  
        
        switch showType {
        case .arrowType:
            self.headImageView.layer.cornerRadius = 0
            self.headImageView.frame = CGRect(x: CGFloat(level) * 15.0 + 10.0, y: 18.5, width: 8.0, height: 11.0)
            self.headImageView.centerY = self.height  * 0.5;
            self.nameLab.frame = CGRect(x: self.headImageView.right + 10.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: self.height)

        case .profileImgType:
            self.headImageView.layer.masksToBounds = true
            self.headImageView.layer.cornerRadius = 16
    //        iv.contentMode = .scaleAspectFit
            self.headImageView.frame = CGRect(x: CGFloat(level) * 15.0 + 10.0, y: self.height * 0.5 - 32.0 * 0.5, width: 32.0, height: 32.0)
            self.nameLab.frame = CGRect(x: self.headImageView.right + 10.0, y: 0.0, width: UIScreen.main.bounds.size.width - self.headImageView.right - 10.0, height: self.height)
        default: break
            
        }
       
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLab)
        contentView.addSubview(headImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
