//
//  Group.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
class Group{
    var groupID:String = ""//unique for all groups
    var groupName:String = ""
    var groupDescription:String = ""
    var groupEvents:[Event] = []
    var groupMembers:[GroupMember] = []
    
    init(groupID:String,groupName:String,groupDescription:String){
        self.groupID = groupID
        self.groupName = groupName
        self.groupDescription = groupDescription
    }
    
    init(){
        
    }
}
