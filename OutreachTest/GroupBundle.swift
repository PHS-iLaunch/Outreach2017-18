//
//  File.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import Firebase

class GroupBundle {
    
    var groupID:String = ""
    var color:String = ""
    var toggled:Bool = true
    
    init(groupID:String,color:String) {
        self.groupID = groupID
        self.color = color
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapVal = snapshot.value as! [String: AnyObject]
        
        self.groupID = snapVal["groupID"] as! String
        self.color = snapVal["color"] as! String
        
    }
    
    init(propertyList : [String: Any]) {
        
        self.groupID = propertyList["groupID"] as! String
        self.color = propertyList["color"] as! String
    }
    
}
