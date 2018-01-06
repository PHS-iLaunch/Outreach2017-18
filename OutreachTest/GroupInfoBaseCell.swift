//
//  GroupInfoBaseCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/4/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupInfoBaseCell:DatasourceCell{
    
    let darkQRBackground:UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.layer.cornerRadius = 48
//        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    let QRCode:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ThemeColor.whitish
        return view
    }()
    
    lazy var QRShareButton:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.popBlue
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var groupDescriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Group Description:\n\(GroupInfoController.own.group.groupDescription)"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
        
        addSubview(darkQRBackground)
        darkQRBackground.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width, heightConstant: self.frame.height/1.5)
        
        addSubview(QRCode)
        QRCode.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant:self.frame.height/3-self.frame.height/6, leftConstant: self.frame.width/2-self.frame.height/6, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.height/3, heightConstant: self.frame.height/3)
        
        let data = GroupInfoController.own.group.groupID.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        let image = filter?.outputImage!
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage = image?.applying(transform)
        
        let tImage = UIImage(ciImage: transformImage!)
        QRCode.image = tImage
        
        addSubview(QRShareButton)
        QRShareButton.anchor(QRCode.bottomAnchor, left: QRCode.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.height/3, heightConstant: self.frame.height/12)
        
        let shareLabel = UILabel()
        shareLabel.text = "Share Group Code"
        shareLabel.font = UIFont.boldSystemFont(ofSize: 20)
        shareLabel.textColor = .black
        addSubview(shareLabel)
        shareLabel.anchor(QRShareButton.topAnchor, left: QRShareButton.leftAnchor, bottom: nil, right: nil, topConstant: self.frame.height/24-shareLabel.intrinsicContentSize.height/2, leftConstant: self.frame.height/6-shareLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        groupDescriptionLabel.frame = CGRect(x: 12, y: self.frame.height/1.5+12, width: self.frame.width - 24, height: 50)
        groupDescriptionLabel.sizeToFit()
        addSubview(groupDescriptionLabel)
        print(groupDescriptionLabel.frame)
        
    }
}
