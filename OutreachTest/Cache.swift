//
//  LocalCache.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/27/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

class Cache{
    var userID:String = ""
    var email:String = ""
    var name:String = ""
    var lastUserRevisionTimestamp:Date = Date()
    var groups:[Group] = []
    
    init(userID:String,email:String,name:String, groups:[Group], lastUserRevisionTimestamp:Date){
        self.userID = userID
        self.email = email
        self.name = name
        self.groups = groups
        self.lastUserRevisionTimestamp = lastUserRevisionTimestamp
        
    }
    
    init(){
        
    }
}

class myCache{
    static var currentCache = Cache()
}
