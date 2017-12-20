//
//  Cells.swift
//  Twitter
//
//  Created by Robert Zhang on 11/9/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class CalendarHeader:DatasourceCell{
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = ThemeColor.border
    }
}

class CalendarFooter:DatasourceCell{
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
    }
}

class UserCalendar: DatasourceCell {
    override var datasourceItem: Any?{
        didSet{
            if let day = datasourceItem as? Int{
                dateLabel.text = "\(day)"
                if day == myCalendar.getDay(){
                    backgroundColor = ThemeColor.lightGreen
                }
            }else{
                dateLabel.text = ""
                backgroundColor = ThemeColor.lightGray
            }
        }
    }
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "7"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
        separatorLineView.isHidden = true
        separatorLineView.backgroundColor = ThemeColor.border
        addSubview(dateLabel)
        
        dateLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 13, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}

