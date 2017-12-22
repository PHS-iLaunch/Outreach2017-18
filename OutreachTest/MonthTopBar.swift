//
//  MonthTopBar.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/19/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class MonthTopBar: DatasourceCell{
    override var datasourceItem: Any?{
        didSet{
            if let temp = datasourceItem as? [String]{
                monthLabel.text = temp[0]
                monthLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: self.frame.height/2-monthLabel.intrinsicContentSize.height/2, leftConstant: self.frame.width/2-monthLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                
                yearLabel.text = temp[1]
                yearLabel.anchor(monthLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: self.frame.width/2-yearLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            }
        }
    }
    
    let monthLabel:UILabel = {
        let label = UILabel()
        label.text = "Month Name"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = ThemeColor.red
        label.textAlignment = .center
        return label
    }()
    
    let yearLabel:UILabel = {
        let label = UILabel()
        label.text = "Year Name"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = ThemeColor.red
        label.textAlignment = .center
        return label
    }()
    
    let leftArrow:UIButton = {
        let imageView = UIButton()
        imageView.setImage(#imageLiteral(resourceName: "arrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        return imageView
    }()
    
    let rightArrow:UIButton = {
        let imageView = UIButton()
        imageView.setImage(#imageLiteral(resourceName: "arrowRight").withRenderingMode(.alwaysOriginal), for: .normal)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
        separatorLineView.isHidden = true
        separatorLineView.backgroundColor = ThemeColor.border
        addSubview(monthLabel)
        addSubview(yearLabel)
        addSubview(leftArrow)
        addSubview(rightArrow)
        
        leftArrow.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: self.frame.height/2-24/2, leftConstant: self.frame.width/12, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 24)
        rightArrow.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: self.frame.height/2-24/2, leftConstant: 0, bottomConstant: 0, rightConstant: self.frame.width/12, widthConstant: 15, heightConstant: 24)
    }
}

class staticDayDisplayBar: DatasourceCell{
    
    override var datasourceItem: Any?{
        didSet{
            dayLabel.text = datasourceItem as? String
        }
    }
    
    let dayLabel:UILabel = {
        let label = UILabel()
        label.text = "Day"
        label.textColor = ThemeColor.red
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
        separatorLineView.isHidden = true
        separatorLineView.backgroundColor = ThemeColor.lightGray
        addSubview(dayLabel)
        
        dayLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
