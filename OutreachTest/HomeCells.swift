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

class UserCellDataPackage{
    var day:Int? = nil
    var hasViewed = false
    var colorStatus:colorStatus = .white
    
    init(_ day:Int?){
        self.day = day;
    }
}

enum colorStatus{
    case green
    case gray
    case white
}

class UserCalendar: DatasourceCell {
    override var datasourceItem: Any?{
        didSet{
            let day = datasourceItem as! UserCellDataPackage
            if day.day != nil{
                dateLabel.text = "\(day.day!)"
                if dateLabel.text == String(myCalendar.getDay()){ //need to also check for month
                    day.colorStatus = .green
                }else{
                    day.colorStatus = .white
                }
            }else{
                dateLabel.text = ""
                day.colorStatus = .gray
            }
            
            if day.colorStatus == .white{
                backgroundColor = ThemeColor.whitish
            }else if day.colorStatus == .gray{
                backgroundColor = ThemeColor.lightGray
            }else if day.colorStatus == .green{
                backgroundColor = ThemeColor.lightGreen
            }
        }
    }
    
    override func prepareForReuse() {
        print("Prepare")
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
        print("Reuse:\(reuseIdentifier)")
        
        dateLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 13, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}

