//
//  addGroupPopup.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/25/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class AddGroupPopup:DatasourceCell{
    
    var screenSize:CGRect = CGRect()
    var initFrame:CGRect = CGRect()
   
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    lazy var joinGroupLabel:UILabel = {
        let label = UILabel()
        label.text = "Join an Existing Group"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = ThemeColor.red
        label.textAlignment = .center
        return label
    }()
    
    lazy var createGroupLabel:UILabel = {
        let label = UILabel()
        label.text = "Create a New Group"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = ThemeColor.red
        label.textAlignment = .center
        return label
    }()
    
    init(position:CGPoint){
        screenSize = (UIApplication.shared.keyWindow?.frame)!
        let width = screenSize.size.width-2*(screenSize.size.width-position.x)
        let height = screenSize.size.height/3
        if position.y > screenSize.height/2{//normal
            print("downl")
            initFrame = CGRect(x:position.x-width,y:position.y-height,width:width,height:height)
            super.init(frame: CGRect(x:position.x,y:position.y,width:0,height:0))
        }else{//thing goes down
            initFrame = CGRect(x:position.x-width,y:position.y+HomeDatasourceController.f.height,width:width,height:height)
            super.init(frame: CGRect(x:position.x,y:position.y+HomeDatasourceController.f.height,width:0,height:0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func joinGroupScreen(){
        HomeDatasourceController.dismissGroupPopupWithoutTap()
        HomeDatasourceController.own.present(UINavigationController(rootViewController: JoinGroupController()), animated: true, completion: nil)
    }
    
    func createGroupScreen(){
        HomeDatasourceController.dismissGroupPopupWithoutTap()
        HomeDatasourceController.own.present(UINavigationController(rootViewController: CreateGroupController()), animated: true, completion: nil)
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.veryLightGray
        layer.cornerRadius = 10
        
        addSubview(joinGroupLabel)
        joinGroupLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: initFrame.height/3-joinGroupLabel.intrinsicContentSize.height/2, leftConstant: initFrame.width/2-joinGroupLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let joinGroupButton = UIView()
        addSubview(joinGroupButton)
        joinGroupButton.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: initFrame.height/3-joinGroupLabel.intrinsicContentSize.height/2-10, leftConstant: initFrame.width/2-joinGroupLabel.intrinsicContentSize.width/2-10, bottomConstant: 0, rightConstant: 0, widthConstant: joinGroupLabel.intrinsicContentSize.width+20, heightConstant: joinGroupLabel.intrinsicContentSize.height+20)
        
        let joinTapGesture = UITapGestureRecognizer(target: self, action: #selector(joinGroupScreen))
        joinGroupButton.addGestureRecognizer(joinTapGesture)
        
        addSubview(createGroupLabel)
        createGroupLabel.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: initFrame.width/2-createGroupLabel.intrinsicContentSize.width/2, bottomConstant: (initFrame.height/3-createGroupLabel.intrinsicContentSize.height/2), rightConstant: 0, widthConstant: 0, heightConstant: 0)
        let createTapGesture = UITapGestureRecognizer(target: self, action: #selector(createGroupScreen))
        
        let createGroupButton = UIView()
        addSubview(createGroupButton)
        createGroupButton.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: initFrame.width/2-createGroupLabel.intrinsicContentSize.width/2-10, bottomConstant: (initFrame.height/3-createGroupLabel.intrinsicContentSize.height/2-10), rightConstant: 0, widthConstant: createGroupLabel.intrinsicContentSize.width+20, heightConstant: createGroupLabel.intrinsicContentSize.height+20)
        
        createGroupButton.addGestureRecognizer(createTapGesture)
        
    }
    
}

