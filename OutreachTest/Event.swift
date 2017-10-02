//
//  Event.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import Firebase

class Event {
    
    var eventID:String = ""
    var eventName:String = ""
    var eventDescription:String = ""
    var eventTime:String = "" //Questionable to its Data Type
    var eventLocation:String = ""
    var parentGroupID:String = ""
    
    init(eventID:String, eventName:String, eventDescription:String, eventTime:String, eventLocation:String, parentGroupID:String) {
        self.eventID = eventID
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.eventTime = eventTime
        self.eventLocation = eventLocation
        self.parentGroupID = parentGroupID
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapVal = snapshot.value as! [String: AnyObject]
        
        self.eventID = snapVal["eventID"] as! String
        self.eventName = snapVal["eventName"] as! String
        self.eventDescription = snapVal["eventDescription"] as! String
        self.eventTime = snapVal["eventTime"] as! String
        self.eventLocation = snapVal["eventLocation"] as! String
        self.parentGroupID = snapVal["parentGroupID"] as! String
        
    }
    
    init(propertyList : [String: Any]) {
        
        self.eventID = propertyList["eventID"] as! String
        self.eventName = propertyList["eventName"] as! String
        self.eventDescription = propertyList["eventDescription"] as! String
        self.eventTime = propertyList["eventTime"] as! String
        self.eventLocation = propertyList["eventLocation"] as! String
        self.parentGroupID = propertyList["parentGroupID"] as! String
    }
    
    init() { //Blank init for DBFirebase, in order to fill in with data snapshot
        
    }
    
}
