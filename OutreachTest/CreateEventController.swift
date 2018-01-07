//
//  CreateEventController.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/7/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class TextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
}

class CreateEventController:DatasourceController,UITextFieldDelegate,UITextViewDelegate{
    
    let eventName:TextField = {
        let text = TextField()
        text.placeholder = "Event Name"
        text.textAlignment = .left
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.backgroundColor = ThemeColor.whitish
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let eventLocation:TextField = {
        let text = TextField()
        text.placeholder = "Event Location"
        text.textAlignment = .left
        text.backgroundColor = ThemeColor.whitish
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    lazy var eventDescription:UITextView = {
        let text = UITextView()
        text.backgroundColor = ThemeColor.whitish
        text.isEditable = true
        text.text = "Event Description"
        text.textAlignment = .left
        text.textColor = ThemeColor.placeholder
        text.delegate = self
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        return text
    }()
    
    let timeContainer:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        return view
    }()
    
    let optionPicker:UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Event","Deadline"])
        sc.tintColor = ThemeColor.whitish
        sc.backgroundColor = ThemeColor.veryLightGray
        sc.layer.cornerRadius = 0
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleOptionChange), for: .valueChanged)
        sc.removeBorders()
        
        let font = UIFont.boldSystemFont(ofSize: 15)
        
        sc.setTitleTextAttributes([NSForegroundColorAttributeName:ThemeColor.red,NSFontAttributeName:font], for: .selected)
        sc.setTitleTextAttributes([NSForegroundColorAttributeName:ThemeColor.lightGray,NSFontAttributeName:font], for: .normal)
        
        return sc
    }()
    
    func handleOptionChange(){
        
    }
    
    let dateStart:UITextField = {
        let text = TextField()
        text.placeholder = "Time Start"
        text.textAlignment = .left
        text.backgroundColor = ThemeColor.whitish
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let dateEnd:UITextField = {
        let text = TextField()
        text.placeholder = "Time End"
        text.textAlignment = .left
        text.backgroundColor = ThemeColor.whitish
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let timeZone:UITextField = {
        let text = TextField()
        text.placeholder = "Time Zone"
        text.textAlignment = .left
        text.backgroundColor = ThemeColor.whitish
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let repeated:UITextField = {
        let text = TextField()
        text.placeholder = "Repeats"
        text.textAlignment = .left
        text.backgroundColor = ThemeColor.whitish
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let alert:UITextField = {
        let text = TextField()
        text.placeholder = "Alerts"
        text.textAlignment = .left
        text.backgroundColor = ThemeColor.whitish
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let done:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.lightGreen
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        view.backgroundColor = ThemeColor.lightGray
        collectionView?.backgroundColor = ThemeColor.lightGray
        
        view.addSubview(eventName)
        eventName.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        view.addSubview(eventLocation)
        eventLocation.anchor(eventName.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        view.addSubview(eventDescription)
        eventDescription.anchor(eventLocation.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 100)
        
        view.addSubview(timeContainer)
        timeContainer.anchor(eventDescription.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 200+6)
        
        timeContainer.addSubview(optionPicker)
        optionPicker.anchor(timeContainer.topAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        timeContainer.addSubview(dateStart)
        dateStart.anchor(optionPicker.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        timeContainer.addSubview(dateEnd)
        dateEnd.anchor(dateStart.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        timeContainer.addSubview(timeZone)
        timeZone.anchor(dateEnd.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        view.addSubview(repeated)
        repeated.anchor(timeContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        view.addSubview(alert)
        alert.anchor(repeated.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        view.addSubview(done)
        done.anchor(alert.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        let doneLabel = UILabel()
        doneLabel.text = "Finish"
        doneLabel.textColor = .black
        doneLabel.font = UIFont.boldSystemFont(ofSize: 20)
        done.addSubview(doneLabel)
        doneLabel.anchor(done.topAnchor, left: done.leftAnchor, bottom: nil, right: nil, topConstant: 25-doneLabel.intrinsicContentSize.height/2, leftConstant: view.frame.width/2-doneLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupNavigationBarItems(){
        let joinGroupLabel = UILabel()
        joinGroupLabel.text = "Create a New Event"
        joinGroupLabel.textColor = ThemeColor.whitish
        joinGroupLabel.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = joinGroupLabel
        
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "x").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:backButton)
        
        navigationController?.navigationBar.barTintColor = ThemeColor.red
        let bounds = self.navigationController!.navigationBar.bounds
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height*1.5)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
}
