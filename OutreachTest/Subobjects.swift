//
//  Group.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

enum Position {
    case admin
    case member
}

class Group {
    var groupID:String
    var groupName:String
    var groupDescription:String
    var lastGroupRevisionTimestamp:Date = Date()
    var events:[Event] = []
    var members:[GroupMember] = []
    
    init(groupID:String,groupName:String,groupDescription:String,events:[Event], members:[GroupMember]) {
        self.groupID = groupID
        self.groupName = groupName
        self.groupDescription = groupDescription
        self.events = events
        self.members = members
    }
}

class Event {
    var eventID:String
    var eventName:String
    var eventDescription:String
    var time:Date
    var location:String
    
    init(eventID:String,eventName:String,eventDescription:String,time:Date,location:String) {
        self.eventID = eventID
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.time = time
        self.location = location
    }
}

class GroupMember {
    var userID:String
    var role:Position
    
    init(userID:String,role:Position) {
        self.userID = userID
        self.role = role
    }
}






