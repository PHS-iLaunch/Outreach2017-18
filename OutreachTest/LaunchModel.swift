//
//  LocalModel.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
class LaunchModel{
    
    static var currentUsername:String = ""
    
    static func saveCurrentUserLocally(){ //call whenever the current user changes
        let ud = UserDefaults.standard
        ud.set(currentUsername,forKey:"currentUsername")
    }
    
    static func retrieveCurrentUserLocally(){ //call at app launch to see if app can skip sign in screens
        let ud = UserDefaults.standard
        
        if let u = ud.string(forKey: "currentUsername"){
            currentUsername = u
        }else{
            currentUsername = ""
        }
        
    }
}
