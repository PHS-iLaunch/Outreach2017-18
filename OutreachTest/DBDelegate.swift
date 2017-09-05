//
//  DBDelegate.swift
//  OutreachTest
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

protocol DBDelegate{
    //Fetch
    static func fetchUserList()->[User]
    static func fetchUser(username:String)->User
    
    static func fetchGroupList()->[Group]
    static func fetchGroup(groupID:String)->Group
    
    static func fetchGroupEvents(groupID:String)->[Event]
    static func fetchGroupEvent(groupID:String,eventID:String)->Event
    
    static func fetchGroupMembers(groupID:String)->[GroupMember]
    static func fetchGroupMember(groupID:String,username:String)->GroupMember
    
    static func fetchUserGroups(username:String)->[Group]
    
//    //Store
//    static func storeUser(username:String) //create new user
//    static func storePassword(username:String,password:String) //set user password
//    static func storeGroupBundleGroupID(username:String,groupID:String) //create new group bundle
//    static func storeGroupBundleColor(username:String,groupID:String,color:String) //set 
    
    static func saveEventTime(groupID:String,eventID:String,time:String)
    
    
}
