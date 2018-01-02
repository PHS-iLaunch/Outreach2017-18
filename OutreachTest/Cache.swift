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
    
    init(userID:String,email:String,name:String){
        self.userID = userID
        self.email = email
        self.name = name
        
    }
    
    init(){
        
    }
}

class myCache{
    static var currentCache = Cache()
}
