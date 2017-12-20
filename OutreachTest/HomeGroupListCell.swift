//
//  HomeGroupListCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/18/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class HomeGroupListHeader: DatasourceCell{
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "My Groups"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.font.withSize(25)
        label.textColor = ThemeColor.whitish
        return label
    }()
    
    let addGroup:UIButton = {
        let imageView = UIButton()
        imageView.setImage(#imageLiteral(resourceName: "newGroup").withRenderingMode(.alwaysOriginal), for: .normal)
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.magenta
        separatorLineView.isHidden = false
        
        addSubview(titleLabel)
        addSubview(addGroup)
        
        titleLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: self.frame.height/2-titleLabel.intrinsicContentSize.height/2, leftConstant: self.frame.width/2-titleLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addGroup.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: self.frame.height/2-40/2, leftConstant: 0, bottomConstant: 0, rightConstant: self.frame.width/12, widthConstant: 40, heightConstant: 40)
        
    }
}

class HomeGroupListCell: DatasourceCell{
    override var datasourceItem: Any?{
        didSet{
            var array:[String] = (datasourceItem as? [String])!
            nameLabel.text = array[0]
            roleLabel.text = array[1]
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "arb"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let roleLabel:UILabel = {
        let label = UILabel()
        label.text = "arb"
        label.textColor = ThemeColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
        separatorLineView.isHidden = false
        
        addSubview(nameLabel)
        addSubview(roleLabel)
        
        nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        roleLabel.anchor(nameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
