//
//  User.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

class User{
    var username:String = ""
    var email:String = ""
    var password:String = ""
    var groupBundles:[GroupBundle] = []
    
    init(username:String, email:String, password:String, groupBundles:[GroupBundle]){
        self.username = username
        self.email = email
        self.password = password
        self.groupBundles = groupBundles
    }
    
    init(){
        
    }
}
