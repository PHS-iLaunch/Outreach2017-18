//
//  GroupMember.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import Firebase

enum Position {
    case admin,member
}

class GroupMember {
    
    var username:String = ""
    var parentGroupID:String = ""
    var position:Position = .member
    
    init(username:String, parentGroupID:String, position:Position){
        self.username = username
        self.parentGroupID = parentGroupID
        self.position = position
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapVal = snapshot.value as! [String: AnyObject]
        
        self.username = snapVal["username"] as! String
        self.parentGroupID = snapVal["parentGroupID"] as! String
        self.position = snapVal["position"] as! Position
        
    }
    
    init(propertyList : [String: Any]) {
        
        self.username = propertyList["username"] as! String
        self.parentGroupID = propertyList["parentGroupID"] as! String
        self.position = propertyList["position"] as! Position
    }
    
    init() { //Blank init for DBFirebase, in order to fill in with data snapshot
        
    }
    
}
