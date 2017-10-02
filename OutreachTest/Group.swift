//
//  Group.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import Firebase

class Group {
    
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
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapVal = snapshot.value as! [String: AnyObject]
        
        self.groupID = snapVal["groupID"] as! String
        self.groupName = snapVal["groupName"] as! String
        self.groupDescription = snapVal["groupDescription"] as! String
        
        let groupEventList = snapVal["groupEvents"] as! [[String : Any]]
        
        for groupEvent in groupEventList {
            self.groupEvents.append(Event(propertyList: groupEvent))
        }
        
        
        let groupMemberList = snapVal["groupMembers"] as! [[String : Any]]
        
        for groupMember in groupMemberList {
            self.groupMembers.append(GroupMember(propertyList: groupMember))
        }
    }
    
    init() { //Blank init for DBFirebase, in order to fill in with data snapshot
        
    }
    
}
