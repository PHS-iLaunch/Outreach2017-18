//
//  MonthSelectPopup.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/25/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class MonthButton:UIButton{
    var isChosen:Bool
    var month:Int
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "Month Abbrev"
        label.font = UIFont.systemFont(ofSize: 25)//UIFont.boldSystemFont(ofSize: 25)
        label.textColor = ThemeColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    init(frame:CGRect,isSelected:Bool,month:Int){
        self.isChosen = isSelected
        self.month = month
        super.init(frame: frame)
        
        if isSelected{
            self.backgroundColor = ThemeColor.lightBlue
        }else{
            self.backgroundColor = ThemeColor.whitish
        }
        dateLabel.text = myCalendar.getMonthAbbrevName(month)
        addSubview(dateLabel)
        
        dateLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: dateLabel.intrinsicContentSize.height, leftConstant: self.frame.width/2-dateLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressed(){
        MonthSelectPopup.pressed(month: month)
    }

}

class MonthSelectPopup:DatasourceCell{
    
    var screenSize:CGRect = CGRect()
    static var currentMonth = 0
    static var currentYear = 0
    
    static let title:UILabel = {
        let label = UILabel()
        label.text = "arb"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = ThemeColor.red
        label.textAlignment = .center
        return label
    }()
    
    let line:UIView = {
        let line = UIView()
        line.backgroundColor = ThemeColor.darkGray
        return line
    }()
    
    let line2:UIView = {
        let line = UIView()
        line.backgroundColor = ThemeColor.darkGray
        return line
    }()
    
    let textField:UITextField = {
        let text = UITextField()
        text.placeholder = "Year Number"
        text.textAlignment = .center
        text.borderStyle = .roundedRect
        text.textColor = ThemeColor.red
        text.font = UIFont.boldSystemFont(ofSize: 20)
        return text
    }()
    
    let doneButton:UIButton = {
        let imageView = UIButton()
        imageView.setImage(#imageLiteral(resourceName: "check").withRenderingMode(.alwaysOriginal), for: .normal)
        imageView.addTarget(HomeDatasourceController, action: #selector(HomeDatasourceController.monthSelectDone), for: .touchUpInside)
        return imageView
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bottomConstraint = NSLayoutConstraint()
    static var buttons:[MonthButton] = []
    
    static func pressed(month:Int){
        for button in buttons{
            if button.month == month{
                button.isChosen = true
                button.backgroundColor = ThemeColor.lightBlue
                MonthSelectPopup.currentMonth = month
                MonthSelectPopup.title.text = "Jump to \(myCalendar.getMonthAbbrevName(MonthSelectPopup.currentMonth)) \(MonthSelectPopup.currentYear)"
            }else{
                button.isChosen = false
                button.backgroundColor = ThemeColor.whitish
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        screenSize = (UIApplication.shared.keyWindow?.frame)!
        backgroundColor = ThemeColor.veryLightGray
        MonthSelectPopup.currentYear = HomeDatasourceController.currentDisplayedYear
        MonthSelectPopup.currentMonth = HomeDatasourceController.currentDisplayedMonth
        
        addSubview(MonthSelectPopup.title)
        MonthSelectPopup.title.text = "Jump to \(myCalendar.getMonthAbbrevName(MonthSelectPopup.currentMonth)) \(MonthSelectPopup.currentYear)"
        MonthSelectPopup.title.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: screenSize.width/2-MonthSelectPopup.title.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant:0 , widthConstant: 0, heightConstant: 0)
        
        
        var monthCounter = 1
        for y in 0...2{
            for x in 0...3{
                let rect = CGRect(x:screenSize.width/4*CGFloat(x),y:MonthSelectPopup.title.bounds.minY-10-CGFloat(y)*screenSize.width/4,width:screenSize.width/4,height:screenSize.height/4)
                var isSelected = false
                if monthCounter == HomeDatasourceController.currentDisplayedMonth{
                    isSelected = true
                }
                let button = MonthButton(frame: rect, isSelected: isSelected, month: monthCounter)
                addSubview(button)
                button.anchor(MonthSelectPopup.title.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 20+CGFloat(y)*screenSize.width/4, leftConstant: screenSize.width/4*CGFloat(x), bottomConstant: 0, rightConstant: 0, widthConstant: screenSize.width/4, heightConstant: screenSize.width/4)
                monthCounter+=1
                MonthSelectPopup.buttons.append(button)
            }
        }
        
        addSubview(line)
        line.anchor(MonthSelectPopup.title.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenSize.width, heightConstant: 1)
        
        addSubview(line2)
        line2.anchor(MonthSelectPopup.title.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 20+3*screenSize.width/4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenSize.width, heightConstant: 1)
        
        addSubview(textField)
        addDoneButtonOnKeyboard()
        textField.anchor(nil, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenSize.width, heightConstant: 60)
        bottomConstraint = NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -(screenSize.height-0.75*screenSize.width-30-MonthSelectPopup.title.intrinsicContentSize.height-20-2-textField.intrinsicContentSize.height-UIApplication.shared.statusBarFrame.height))
        addConstraint(bottomConstraint)
        textField.keyboardType = .numberPad
        
        addSubview(doneButton)
        doneButton.anchor(self.bottomAnchor, left: self.leftAnchor, bottom:nil, right: nil, topConstant: -screenSize.height/4, leftConstant: screenSize.width/2-50, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.blackOpaque
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(MonthSelectPopup.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        doneToolbar.tintColor = ThemeColor.red
        doneToolbar.barTintColor = ThemeColor.veryLightGray
        self.textField.inputAccessoryView = doneToolbar
    }
    
    func dismissKeyboard(){
        if let text:String = textField.text{
            if let num = Int(text){
                if num >= 0{
                    textField.resignFirstResponder()
                    MonthSelectPopup.currentYear = num
                    MonthSelectPopup.title.text = "Jump to \(myCalendar.getMonthAbbrevName(MonthSelectPopup.currentMonth)) \(MonthSelectPopup.currentYear)"
                }
            }else if text == ""{
                textField.resignFirstResponder()
            }
        }
    }
    
    func doneButtonAction(){
        if let text:String = textField.text{
            if let num = Int(text){
                if num >= 0{
                    textField.resignFirstResponder()
                    MonthSelectPopup.currentYear = num
                    MonthSelectPopup.title.text = "Jump to \(myCalendar.getMonthAbbrevName(MonthSelectPopup.currentMonth)) \(MonthSelectPopup.currentYear)"
                }
            }else if text == ""{
                textField.resignFirstResponder()
            }
        }
    }
    
    func handleKeyboardNotification(notification:Notification){
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue!
            
            let isKeyShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            if isKeyShowing{
                bottomConstraint.constant = -keyboardFrame.height-textField.intrinsicContentSize.height+10
            }else{
                bottomConstraint.constant = -(screenSize.height-0.75*screenSize.width-30-MonthSelectPopup.title.intrinsicContentSize.height-20-4-textField.intrinsicContentSize.height-UIApplication.shared.statusBarFrame.height)
            }
        }
    }
}
