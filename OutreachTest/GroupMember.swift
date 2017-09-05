//
//  GroupMember.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

enum Position{
    case admin,member
}

class GroupMember{
    var username:String = ""
    var parentGroupID:String = ""
    var position:Position = .member
    
    init(username:String,parentGroupID:String,position:Position){
        self.username = username
        self.parentGroupID = parentGroupID
        self.position = position
    }
    
    init(){
        
    }
}
