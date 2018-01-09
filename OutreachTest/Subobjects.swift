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
    var location:String
    
    var startTime:Date
    var endTime:Date?
    var eventType:EventType
    
    var alarms:[AlarmType]
    var repeats:RepeatType
    
    init(eventID:String,eventName:String,eventDescription:String,startTime:Date,endTime:Date,eventType:EventType,location:String,repeats:RepeatType,alarms:[AlarmType]) {
        self.eventID = eventID
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.location = location
        
        self.startTime = startTime
        self.endTime = endTime
        self.eventType = eventType
        self.repeats = repeats
        self.alarms = alarms
    }
}

class GroupMember {
    var userID:String = ""
    var role:Position = .member
    
    init(userID:String,role:Position) {
        self.userID = userID
        self.role = role
    }
    
    init(){
        
    }
}






