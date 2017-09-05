
//
//  File.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
class GroupBundle{
    var groupID:String = ""
    var color:String = ""
    var toggled:Bool = true
    
    init(groupID:String,color:String){
        self.groupID = groupID
        self.color = color
    }
    
    init(){
        
    }
}
