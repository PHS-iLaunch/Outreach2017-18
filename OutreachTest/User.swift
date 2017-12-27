//
//  User.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

class User {
    var ID:String = ""
    var name:String = ""
    var email:String = ""
    //var password:String = ""
    var groupBundles:[GroupBundle] = []
    
    init(ID:String, name:String, email:String, groupBundles:[GroupBundle]) {
        self.ID = ID
        self.name = name
        self.email = email
        self.groupBundles = groupBundles
    }
    
    init(){
        
    }
    
}
