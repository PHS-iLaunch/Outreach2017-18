//
//  DB.swift
//  OutreachTest
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import Firebase

class DBFirebase : DBDelegate {
    
    static func fetchUserList()->[User] {
        
        let userRef = FIRDatabase.database().reference(withPath: "users")
        var userList = [User]()
        
        userRef.observe(.value, with: {snapshot in
            for user in snapshot.children.allObjects {
                
                userList.append(User(snapshot: user as! FIRDataSnapshot))
                //Note: Questionable- not sure if the object returned by .allObjects is
                //going to be a FIRDataSnapshot
            }
        })
        return userList
    }
    
    
    static func fetchUser(username:String)->User {
        
        let ref = FIRDatabase.database().reference(withPath: "users").child(username)
        var user = User()
        
        ref.observe(.value, with: {snapshot in
            user = User(snapshot: snapshot)
        })
        
        return user
    }
    
    
    static func fetchGroupList()->[Group] {
        let groupRef = FIRDatabase.database().reference(withPath: "groups")
        var groupList = [Group]()
        
        groupRef.observe(.value, with: {snapshot in
            for group in snapshot.children.allObjects {
                
                groupList.append(Group(snapshot: group as! FIRDataSnapshot))
                //Note: Questionable- not sure if the object returned by .allObjects is
                //going to be a FIRDataSnapshot
            }
        })
        
        return groupList
    }
    
    
    static func fetchGroup(groupID:String)->Group {
        
        let ref = FIRDatabase.database().reference(withPath: "group").child(groupID)
        var group = Group()
        
        ref.observe(.value, with: {snapshot in
            group = Group(snapshot: snapshot)
        })
        
        return group
    }
    
    
    static func fetchGroupEvents(groupID:String)->[Event] {
        let groupRef = FIRDatabase.database().reference(withPath: "groups").child(groupID).child("groupEvents")
        
        var eventList = [Event]()
        
        groupRef.observe(.value, with: {snapshot in
            for event in snapshot.children.allObjects {
                
                eventList.append(Event(snapshot: event as! FIRDataSnapshot))
                //Note: Questionable- not sure if the object returned by .allObjects is
                //going to be a FIRDataSnapshot
            }
        })
        
        return eventList
    }
    
    
    static func fetchGroupEvent(groupID:String, eventID:String)->Event {
        
        let ref = FIRDatabase.database().reference(withPath: "group").child(groupID).child("groupEvents").child(eventID)
        
        var event = Event()
        
        ref.observe(.value, with: {snapshot in
            event = Event(snapshot: snapshot)
        })
        
        return event
    }
    
    
    static func fetchGroupMembers(groupID:String)->[GroupMember] {
        
        let groupMemberRef = FIRDatabase.database().reference(withPath: "groups").child(groupID).child("groupMembers")
        
        var memberList = [GroupMember]()
        
        groupMemberRef.observe(.value, with: {snapshot in
            for member in snapshot.children.allObjects {
                
                memberList.append(GroupMember(snapshot: member as! FIRDataSnapshot))
                //Note: Questionable- not sure if the object returned by .allObjects is
                //going to be a FIRDataSnapshot
            }
        })
        
        return memberList
    }
    
    
    static func fetchGroupMember(groupID:String, username:String)->GroupMember {
        
        let ref = FIRDatabase.database().reference(withPath: "group").child(groupID).child("groupMembers").child(username)
        
        var groupMember = GroupMember()
        
        ref.observe(.value, with: {snapshot in
            groupMember = GroupMember(snapshot: snapshot)
        })
        
        return groupMember
    }
    
    
    static func fetchUserGroups(username:String)->[Group]{
        /*
         This happens to be complicated
         First, we obtain a reference to a user's groupBundles
         Then, we observe it- and, for every groupBundle, we get a groupID
         We then search in groups and create a new reference to the group with the specified groupID
         We then observe that group, and put that into a list
         Then the list is finally returned
         Points that may cause errors are marked
         */
        
        let userGroupRef = FIRDatabase.database().reference(withPath: "users").child(username).child("groupBundles")
        
        var userGroupList = [Group]()
        
        userGroupRef.observe(.value, with: {snapshot in
            for groupBundle in snapshot.children.allObjects {
                
                let snapVal = (groupBundle as! FIRDataSnapshot).value as! [String: AnyObject]
                //May not be able to cast groupBundle as a FIRDataSnapshot
                
                let groupID = snapVal["groupID"] as! String
                
                let findGroupRef = FIRDatabase.database().reference(withPath: "groups").child(groupID)
                
                //May not be able to nest observes
                findGroupRef.observe(.value, with: {groupSnapshot in
                    userGroupList.append(Group(snapshot: groupSnapshot))
                })
                
            }
        })
        
        return userGroupList
    }
    
    //MARK: Storing
    
    static func storeUsername(username:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "users")
        
        let userRef = ref.child("username")
        
        userRef.setValue(username)
        
    }
    
    
    static func storeGroupBundleGroupID(username:String, groupID:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "users")
        
        let userRef = ref.child(username).child("groupBundles").child(groupID)
        
        userRef.setValue(groupID)
    }
    

    static func storeGroupBundleColor(username:String, groupID:String, color:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "users")
        
        let userRef = ref.child(username).child("groupBundles").child(groupID).child("color")
        
        userRef.setValue(color)
        
    }
    
    
    static func storeGroupBundleToggle(username:String, groupID:String, toggle: Bool) {
        
        let ref = FIRDatabase.database().reference(withPath: "users")
        
        let userRef = ref.child(username).child("groupBundles").child(groupID).child("toggle")
        
        userRef.setValue(toggle)
        
    }
    
    
    static func storeGroupID(groupID:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID)
        
        groupRef.setValue(groupID)
        
    }
    
    
    static func storeGroupName(groupID:String, groupName:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupName")
        
        groupRef.setValue(groupName)
        
    }
    
    
    static func storeGroupDesc(groupID:String, groupDesc:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupDesc")
        
        groupRef.setValue(groupDesc)
        
    }
    
    
    static func storeGroupParentID(groupID:String, groupParentID:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupParentID")
        
        groupRef.setValue(groupParentID)
    }

    
    
    static func storeEvent(groupID:String, eventName:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupEvents").child("eventName")
        
        groupRef.setValue(eventName)
        
    }
    
    
    static func storeEventDesc(groupID:String, eventName:String, eventDesc:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupEvents").child("eventDesc")
        
        groupRef.setValue(eventDesc)
        
    }
    
    
    static func storeEventTime(groupID:String, eventName:String, time:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupEvents").child("eventTime")
        
        groupRef.setValue(time)
    }
    
    
    static func storeEventLocation(groupID:String, eventName:String, location:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupEvents").child("eventLocation")
        
        groupRef.setValue(location)
        
    }
    
    
    static func storeGroupMember(groupID:String, memberUsername:String) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupMembers").child(memberUsername)
        
        groupRef.setValue(memberUsername)
        
    }

    
    static func storeGroupMemberRole(groupID:String, memberUsername:String, role:Int) {
        
        let ref = FIRDatabase.database().reference(withPath: "groups")
        
        let groupRef = ref.child(groupID).child("groupMembers").child(memberUsername).child("role")
        
        groupRef.setValue(role)
        
    }






}
