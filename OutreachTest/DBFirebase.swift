//
//  DB.swift
//  OutreachTest
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

class DBFirebase:DBDelegate{
    static func fetchUserList()->[User]{
        return []
    }
    static func fetchUser(username:String)->User{
        return User()
    }
    
    static func fetchGroupList()->[Group]{
        return []
    }
    static func fetchGroup(groupID:String)->Group{
        return Group()
    }
    
    static func fetchGroupEvents(groupID:String)->[Event]{
        return []
    }
    static func fetchGroupEvent(groupID:String,eventID:String)->Event{
        
        return Event()
    }
    
    static func fetchGroupMembers(groupID:String)->[GroupMember]{
        return []
    }
    static func fetchGroupMember(groupID:String,username:String)->GroupMember{
        return GroupMember()
    }
    
    static func fetchUserGroups(username:String)->[Group]{
        return []
    }
    
    static func saveEventTime(groupID:String,eventID:String,time:String){
        //change
    }
}
