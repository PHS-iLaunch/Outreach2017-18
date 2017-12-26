////
////  DBDelegate.swift
////  OutreachTest
////
////  Created by Robert Zhang on 9/4/17.
////  Copyright © 2017 iLaunch. All rights reserved.
////
//
//import Foundation
//
//protocol DBDelegate{
//    //Fetch
//    static func fetchUserList()->[User]
//    static func fetchUser(username:String)->User
//
//    static func fetchGroupList()->[Group]
//    static func fetchGroup(groupID:String)->Group
//
//    static func fetchGroupEvents(groupID:String)->[Event]
//    static func fetchGroupEvent(groupID:String,eventID:String)->Event
//
//    static func fetchGroupMembers(groupID:String)->[GroupMember]
//    static func fetchGroupMember(groupID:String, username:String)->GroupMember
//
//    static func fetchUserGroups(username:String)->[Group]
//
//    //Store
//
//    //Users
//    static func storeUsername(username:String)
//    static func storeGroupBundleGroupID(username:String, groupID:String)
//    static func storeGroupBundleColor(username:String, groupID:String, color:String)
//    static func storeGroupBundleToggle(username:String, groupID:String, toggle: Bool)
//
//    //Groups
//    static func storeGroupID(groupID:String)
//    static func storeGroupName(groupID:String, groupName:String)
//    static func storeGroupDesc(groupID:String, groupDesc:String)
//    static func storeGroupParentID(groupID:String, groupParentID:String)
//    static func storeEvent(groupID:String, eventName:String)
//    static func storeEventDesc(groupID:String, eventName:String, eventDesc:String)
//    static func storeEventTime(groupID:String, eventName:String, time:String)
//    static func storeEventLocation(groupID:String, eventName:String, location:String)
//    static func storeGroupMember(groupID:String, memberUsername:String)
//    static func storeGroupMemberRole(groupID:String, memberUsername:String, role:Int)
//
//
//    /*
//     As of 10/15, users are identified based on their username and groups are identified by the group name.
//     Later, a unique identifier for each group might be added, with the addition of certain functions
//     Every storage function works the same way-
//     First, a reference is created either users or groups
//     Then, the reference is specified to whatever needs to be stored
//     The value of that key is then set in the last line.
//     */
//
//}

