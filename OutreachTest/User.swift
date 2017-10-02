//
//  User.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    var username:String = ""
    var email:String = ""
    var password:String = ""
    var groupBundles:[GroupBundle] = []
    
    init(username:String, email:String, password:String, groupBundles:[GroupBundle]) {
        self.username = username
        self.email = email
        self.password = password
        self.groupBundles = groupBundles
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapVal = snapshot.value as! [String: AnyObject]
        
        self.username = snapVal["username"] as! String
        self.email = snapVal["email"] as! String
        self.password = snapVal["password"] as! String

        let groupBundleList = snapVal["groupBundles"] as! [[String : Any]]
        
        for groupBundle in groupBundleList {
            self.groupBundles.append(GroupBundle(propertyList: groupBundle))
        }
        
    }
    
    init() { //Blank init for DBFirebase, in order to fill in with data snapshot
        
    }
    
}
