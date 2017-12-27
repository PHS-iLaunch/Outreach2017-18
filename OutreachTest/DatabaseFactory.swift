//
//  DatabaseFactory.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/26/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

class DatabaseFactory{
    static func setupInitialState(){
        FirebaseImpl.setupInitialState()
    }
    
    static func createUser(name:String?, email: String?, password: String?){
        FirebaseImpl.createUser(name:name, email: email, password: password)
    }
    
    static func isLoggedIn()->Bool{
        return FirebaseImpl.isLoggedIn()
    }
    
    static func signOut(){
        FirebaseImpl.signOut()
    }
    
    static func logIn(email:String?,password:String?){
        FirebaseImpl.logIn(email:email,password:password)
    }
}
