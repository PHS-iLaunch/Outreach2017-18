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
    
    lazy var eventName:TextField = {
        let text = TextField()
        text.placeholder = "Event Name"
        text.textAlignment = .left
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.delegate = self
        text.backgroundColor = ThemeColor.whitish
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.autocorrectionType = .no
        text.returnKeyType = .done
        return text
    }()
    
    lazy var eventLocation:TextField = {
        let text = TextField()
        text.placeholder = "Event Location"
        text.textAlignment = .left
        text.backgroundColor = ThemeColor.whitish
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.delegate = self
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.returnKeyType = .done
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
        text.returnKeyType = .default
        return text
    }()
    
    let timeContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
    
    let dateStart:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        return view
    }()
    
    let dateStartText:UILabel = {
        let text = UILabel()
        text.text = "Time Start"
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let dateEnd:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        return view
    }()
    
    let dateEndText:UILabel = {
        let text = UILabel()
        text.text = "Time End"
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    lazy var timeZone:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseTimeZone))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    let timeZoneIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowRight").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.placeholder
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let timeZoneText:UILabel = {
        let text = UILabel()
        text.text = "Time Zone"
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    lazy var repeated:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseRepeat))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    let repeatedIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowRight").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.placeholder
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let repeatedText:UILabel = {
        let label = UILabel()
        label.text = "Repeats"
        label.textColor = ThemeColor.placeholder
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var alert:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseAlerts))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    let alertIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowRight").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.placeholder
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let alertText:UILabel = {
        let label = UILabel()
        label.text = "Alerts"
        label.textColor = ThemeColor.placeholder
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
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
        timeContainer.anchor(eventDescription.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 200+6+2)
        timeContainerHeightConstraint = timeContainer.heightAnchor.constraint(equalToConstant: 208)
        timeContainerHeightConstraint?.isActive = true
        
        timeContainer.addSubview(optionPicker)
        optionPicker.anchor(timeContainer.topAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        timeContainer.addSubview(dateStart)
        dateStart.anchor(optionPicker.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        dateStart.addSubview(dateStartText)
        dateStartText.anchor(dateStart.topAnchor, left: dateStart.leftAnchor, bottom: nil, right: nil, topConstant: 25-dateStartText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        timeContainer.addSubview(dateEnd)
        dateEnd.anchor(dateStart.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        timeEndHeightConstraint = dateEnd.heightAnchor.constraint(equalToConstant: 50)
        timeEndHeightConstraint?.isActive = true
        
        dateEnd.addSubview(dateEndText)
        dateEndText.anchor(dateEnd.topAnchor, left: dateEnd.leftAnchor, bottom: nil, right: nil, topConstant: 25-dateEndText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        timeContainer.addSubview(timeZone)
        timeZone.anchor(dateEnd.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        timeZonePadding = timeZone.topAnchor.constraint(equalTo: dateEnd.bottomAnchor, constant: 1)
        timeZonePadding?.isActive = true
        
        timeZone.addSubview(timeZoneText)
        timeZoneText.anchor(timeZone.topAnchor, left: timeZone.leftAnchor, bottom: nil, right: nil, topConstant: 25-timeZoneText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        timeZone.addSubview(timeZoneIcon)
        timeZoneIcon.anchor(timeZone.topAnchor, left: nil, bottom: nil, right: timeZone.rightAnchor, topConstant: 25-20, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 20, heightConstant: 40)
        
        view.addSubview(repeated)
        repeated.anchor(timeContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        view.addSubview(repeatedIcon)
        repeatedIcon.anchor(repeated.topAnchor, left: nil, bottom: nil, right: repeated.rightAnchor, topConstant: 25-20, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 20, heightConstant: 40)
        
        view.addSubview(repeatedText)
        repeatedText.anchor(repeated.topAnchor, left: repeated.leftAnchor, bottom: nil, right: nil, topConstant: 25-repeatedText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(alert)
        alert.anchor(repeated.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        view.addSubview(alertIcon)
        alertIcon.anchor(alert.topAnchor, left: nil, bottom: nil, right: alert.rightAnchor, topConstant: 25-20, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 20, heightConstant: 40)
        
        view.addSubview(alertText)
        alertText.anchor(alert.topAnchor, left: alert.leftAnchor, bottom: nil, right: nil, topConstant: 25-alertText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(done)
        done.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
        
        let doneLabel = UILabel()
        doneLabel.text = "Finish"
        doneLabel.textColor = .black
        doneLabel.font = UIFont.boldSystemFont(ofSize: 20)
        done.addSubview(doneLabel)
        doneLabel.anchor(done.topAnchor, left: done.leftAnchor, bottom: nil, right: nil, topConstant: 25-doneLabel.intrinsicContentSize.height/2, leftConstant: view.frame.width/2-doneLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        timeContainer.addGestureRecognizer(tapGesture)
        
        addDoneButtonOnKeyboard()
    }
    
    var timeContainerHeightConstraint:NSLayoutConstraint?
    var timeEndHeightConstraint:NSLayoutConstraint?
    var timeZonePadding:NSLayoutConstraint?
    
    func handleOptionChange(){
        self.timeContainerHeightConstraint?.constant = self.optionPicker.selectedSegmentIndex == 0 ? 208 : 157
        self.timeEndHeightConstraint?.constant = self.optionPicker.selectedSegmentIndex == 0 ? 50 : 0
        self.timeZonePadding?.constant = self.optionPicker.selectedSegmentIndex == 0 ? 1 : 0
        dateStartText.text = self.optionPicker.selectedSegmentIndex == 0 ? "Time Start" : "Time to be Completed"
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
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
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.blackOpaque
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(dismissKeyboard))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        doneToolbar.tintColor = ThemeColor.red
        doneToolbar.barTintColor = ThemeColor.veryLightGray
        
        self.eventDescription.inputAccessoryView = doneToolbar
    }
    
    func chooseRepeat(){
        self.navigationController?.pushViewController(ChooseRepeat(), animated: true)
    }
    
    func chooseAlerts(){
        self.navigationController?.pushViewController(ChooseAlerts(), animated: true)
    }
    
    func chooseTimeZone(){
        self.navigationController?.pushViewController(ChooseTimeZone(), animated: true)
    }
    
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dismissKeyboard(){
        eventName.resignFirstResponder()
        eventLocation.resignFirstResponder()
        eventDescription.resignFirstResponder()
    }
    
   
}
