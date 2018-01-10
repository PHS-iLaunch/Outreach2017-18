//
//  CreateGroupController.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/2/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import UIKit

class CreateGroupController:UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    lazy var groupNameLabel:UITextField = {
        let text = UITextField()
        text.placeholder = "Group Name (required)"
        text.textAlignment = .center
        text.autocorrectionType = .no
        text.autocapitalizationType = .none
        text.borderStyle = .roundedRect
        text.textColor = ThemeColor.red
        text.returnKeyType = .done
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        text.delegate = self
        return text
    }()
    
    lazy var groupDescriptionLabel:UITextView = {
        let text = UITextView()
        text.isEditable = true
        text.text = "Group Description (required)"
        text.textAlignment = .left
        text.textColor = ThemeColor.placeholder
        text.delegate = self
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let doneButton:UIButton = {
        let imageView = UIButton()
        imageView.setImage(#imageLiteral(resourceName: "checkDesaturated").withRenderingMode(.alwaysOriginal), for: .normal)
        imageView.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return imageView
    }()
    
    func buttonPressed(){
        if !(groupNameLabel.text?.isEmpty)! && groupDescriptionLabel.textColor == ThemeColor.darkGray && groupDescriptionLabel.text != ""{
            //Register Group
            DatabaseFactory.DB.createGroup(name: groupNameLabel.text, description: groupDescriptionLabel.text)
            //
            goBack()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        view.backgroundColor = ThemeColor.whitish
        
        view.addSubview(groupNameLabel)
        groupNameLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 60)
        
        view.addSubview(groupDescriptionLabel)
        groupDescriptionLabel.anchor(groupNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height/5)
        
        view.addSubview(doneButton)
        doneButton.anchor(groupDescriptionLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: view.frame.width/2-50, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        addDoneButtonOnKeyboard()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        groupDescriptionLabel.backgroundColor = .white
        if groupDescriptionLabel.textColor == ThemeColor.placeholder {
            textView.text = nil
            textView.textColor = ThemeColor.darkGray
        }
    }
    
    func textFieldDidChange(){
        if !(groupNameLabel.text?.isEmpty)! && !groupDescriptionLabel.text.isEmpty && groupDescriptionLabel.textColor == ThemeColor.darkGray{
            doneButton.setImage(#imageLiteral(resourceName: "check").withRenderingMode(.alwaysOriginal), for: .normal)
        }else{
            doneButton.setImage(#imageLiteral(resourceName: "checkDesaturated").withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if !(groupNameLabel.text?.isEmpty)! && !groupDescriptionLabel.text.isEmpty && groupDescriptionLabel.textColor == ThemeColor.darkGray{
            doneButton.setImage(#imageLiteral(resourceName: "check").withRenderingMode(.alwaysOriginal), for: .normal)
        }else{
            doneButton.setImage(#imageLiteral(resourceName: "checkDesaturated").withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "Group Description (required)"
            textView.textColor = ThemeColor.placeholder
            doneButton.setImage(#imageLiteral(resourceName: "checkDesaturated").withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    func dismissKeyboard(){
        groupNameLabel.resignFirstResponder()
        groupDescriptionLabel.resignFirstResponder()
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.blackOpaque
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        doneToolbar.tintColor = ThemeColor.red
        doneToolbar.barTintColor = ThemeColor.veryLightGray
        
        self.groupDescriptionLabel.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction(){
        groupDescriptionLabel.resignFirstResponder()
    }
    
    func setupNavigationBarItems(){
        let createGroupLabel = UILabel()
        createGroupLabel.text = "Create a New Group"
        createGroupLabel.textColor = ThemeColor.whitish
        createGroupLabel.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = createGroupLabel
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
