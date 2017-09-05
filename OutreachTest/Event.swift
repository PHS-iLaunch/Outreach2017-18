//
//  Event.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
class Event{
    var eventID:String = ""
    var eventName:String = ""
    var eventDescription:String = ""
    var eventTime:String = "" //Questionable to its Data Type
    var eventLocation:String = ""
    var parentGroupID:String = ""
    
    init(eventID:String,eventName:String,eventDescription:String,eventTime:String,eventLocation:String,parentGroupID:String){
        self.eventID = eventID
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.eventTime = eventTime
        self.eventLocation = eventLocation
        self.parentGroupID = parentGroupID
    }
    
    init(){
        
    }
}
