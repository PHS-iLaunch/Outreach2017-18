//
//  GroupMembersSubCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/5/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class MiniUser{ //intermediate object bridging users and groups used only for members display below
    var userID:String = ""
    var name:String = ""
    var profileImage:UIImage = UIImage()
    
    init(userID:String,name:String,image:UIImage) {
        self.userID = userID
        self.name = name
        self.profileImage = image
    }
    
    init(){
        
    }
}

class GroupMembersSubCell:DatasourceCell{
    
    var cellUser:MiniUser = MiniUser()
    var member:GroupMember = GroupMember()
    
    override var datasourceItem: Any?{
        didSet{
            member = (datasourceItem as? GroupMember)!
            DatabaseFactory.DB.getMiniUser(userID: member.userID) { (user) in
                if let userExists = user{
                    self.cellUser = userExists
                    self.addSubview(self.profile)
                    self.profile.image = self.cellUser.profileImage
                    self.profile.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.height-24, heightConstant: self.frame.height-24)
                    
                    self.addSubview(self.name)
                    self.name.text = self.cellUser.name
                    self.name.anchor(self.topAnchor, left: self.profile.rightAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                    
                    self.addSubview(self.role)
                    if self.member.role == .admin{
                        self.role.text = "admin"
                    }else{
                        self.role.text = "member"
                    }
                    self.role.anchor(self.name.bottomAnchor, left: self.profile.rightAnchor, bottom: nil, right: nil, topConstant: 6, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                    
                    let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.add(tap:)))
                    self.addGestureRecognizer(gestureTap)
                }
            }
        }
    }
    
    func add(tap:UITapGestureRecognizer){
        GroupInfoController.own.present(UINavigationController(rootViewController:ProfileController(userID: member.userID)), animated: true, completion: nil)
    }
    
    lazy var profile:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = (self.frame.height-24)/2
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var name:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var role:UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
    }
}
