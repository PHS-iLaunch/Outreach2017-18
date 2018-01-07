//
//  MonthTopBar.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/19/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

////////////TOP BARS///////////

class MonthTopBar: DatasourceCell{
    var hasViewed = false
    
    override var datasourceItem: Any?{
        didSet{
            if let temp = datasourceItem as? [String]{
                monthLabel.text = temp[0]
                yearLabel.text = temp[1]
                
                if !hasViewed{
                    monthLabel.frame = CGRect(x: self.frame.width/2, y: self.frame.height/2, width: 200, height: 30)
                    monthLabel.center = CGPoint(x:self.frame.width/2,y:self.frame.height/2)
                    
                    yearLabel.anchor(monthLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: self.frame.width/2-yearLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                    
                    selectionButton.anchor(monthLabel.topAnchor, left: monthLabel.leftAnchor, bottom: yearLabel.bottomAnchor, right: monthLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                }
                hasViewed = true
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
    
    lazy var selectionButton:UIButton = {
        let imageView = UIButton()
        imageView.backgroundColor = .clear
        imageView.addTarget(self, action: #selector(newMonthSelect), for: .touchUpInside)
        return imageView
    }()
    
    lazy var leftArrow:UIButton = {
        let imageView = UIButton()
        imageView.setImage(#imageLiteral(resourceName: "arrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imageView.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
        return imageView
    }()
    
    lazy var rightArrow:UIButton = {
        let imageView = UIButton()
        imageView.setImage(#imageLiteral(resourceName: "arrowRight").withRenderingMode(.alwaysOriginal), for: .normal)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imageView.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
        imageView.adjustsImageWhenHighlighted = true
        return imageView
    }()
    
    func newMonthSelect(){
        HomeDatasourceController.own.newMonthSelect(startingImage:selectionButton)
    }
    
    func leftClick(){
        leftArrow.pulsate()
        HomeDatasourceController.own.leftButtonClick()
    }
    
    func rightClick(){
        rightArrow.pulsate()
        HomeDatasourceController.own.rightButtonClick()
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
        separatorLineView.isHidden = true
        separatorLineView.backgroundColor = ThemeColor.border
        addSubview(monthLabel)
        addSubview(yearLabel)
        addSubview(leftArrow)
        addSubview(rightArrow)
        addSubview(selectionButton)
        
        leftArrow.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: self.frame.height/2-30/2, leftConstant: self.frame.width/12, bottomConstant: 0, rightConstant: 0, widthConstant: 35+17, heightConstant: 35)
        rightArrow.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: self.frame.height/2-30/2, leftConstant: 0, bottomConstant: 0, rightConstant: self.frame.width/12, widthConstant: 35+17, heightConstant: 35)
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

////////////CELLS///////////

class UserCellDataPackage{
    var day:Int? = nil
    var notMonthDay:Int? = nil
    var hasViewed = false
    var colorStatus:colorStatus = .white
    var mStatus:monthStatus = .current
    
    init(_ day:Int?){
        self.day = day;
    }
}

enum monthStatus{
    case before
    case current
    case after
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
            }else{
                dateLabel.text = "\(day.notMonthDay!)"
                dateLabel.textColor = ThemeColor.lightGray
            }
            
            if day.colorStatus == .white{
                backgroundColor = ThemeColor.whitish
            }else if day.colorStatus == .gray{
                backgroundColor = ThemeColor.veryLightGray
            }else if day.colorStatus == .green{
                backgroundColor = ThemeColor.lightGreen
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

////////////GROUPS///////////

class HomeGroupListHeader: DatasourceCell{
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "My Groups"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.font.withSize(25)
        label.textColor = ThemeColor.whitish
        return label
    }()
    
    lazy var addGroup:UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "newGroup"))
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()
    
    func add(tap:UITapGestureRecognizer){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations:{
            self.addGroup.transform = CGAffineTransform(rotationAngle:CGFloat.pi/4.0)
        },completion:nil)
        HomeDatasourceController.onGroupPopup(image:addGroup, h: self)
    }
    
    func minus(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations:{
            self.addGroup.transform = CGAffineTransform(rotationAngle:0)
        },completion:nil)
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.magenta
        separatorLineView.isHidden = false
        
        addSubview(titleLabel)
        addSubview(addGroup)
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.add(tap:)))
        addGroup.addGestureRecognizer(gestureTap)
        addGroup.isUserInteractionEnabled = true
        
        titleLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: self.frame.height/2-titleLabel.intrinsicContentSize.height/2, leftConstant: self.frame.width/2-titleLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addGroup.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: self.frame.height/2-40/2, leftConstant: 0, bottomConstant: 0, rightConstant: self.frame.width/12, widthConstant: 40, heightConstant: 40)
        
    }
}

class HomeGroupListCell: DatasourceCell{
    
    var groupID:String = ""
    
    override var datasourceItem: Any?{
        didSet{
            var group:Group = (datasourceItem as? Group)!
            nameLabel.text = group.groupName
            for member in group.members{
                if member.userID == myCache.currentCache.userID{
                    if member.role == .admin{
                        roleLabel.text = "admin"
                    }else if member.role == .member{
                        roleLabel.text = "member"
                    }
                }
            }
            groupID = group.groupID
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
    
    let buttonView:UIView = {
        let view = UIView()
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.whitish
        separatorLineView.isHidden = false
        
        addSubview(nameLabel)
        addSubview(roleLabel)
        
        nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        roleLabel.anchor(nameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 6, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addSubview(buttonView)
        buttonView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width, heightConstant: self.frame.height)
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.add(tap:)))
        buttonView.addGestureRecognizer(gestureTap)
        
    }
    
    func add(tap:UITapGestureRecognizer){
        HomeDatasourceController.own.present(UINavigationController(rootViewController: GroupInfoController(groupID:self.groupID)), animated: true, completion: nil)
    }
}


///UNUSED:
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
