//
//  UserPortal.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
class UserPortalModel{
    //Handles all user signin/out/up functionalities.
    //Which GUI this corresponds with: Sign Up Screen, Sign In Screen, Sign Out Button from Home Screen
    
    static func signIn(username:String,password:String)->Bool{
        //make sure both exist and match from database, and if verified, return true
        return true
    }
    
    static func signUp()->Bool{
        //init and verify new user here, and if verified, return true
        return true
    }
    
    static func signOut(){
        
    }
}
