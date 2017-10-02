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
                //May not be able to case groupBundle as a FIRDataSnapshot
                
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
    
    static func saveEventTime(groupID:String,eventID:String,time:String){
        //change
    }
}
