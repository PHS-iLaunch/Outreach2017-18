//
//  File.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
enum Position {
    case admin
    case member
}

class GroupBundle {
    var groupID:String = ""
    var color:String = ""
    var toggled:Bool = true
    var role:Position = .member
    
    init(groupID:String,color:String, position:Position) {
        self.groupID = groupID
        self.color = color
        self.role = position
    }
    
}
