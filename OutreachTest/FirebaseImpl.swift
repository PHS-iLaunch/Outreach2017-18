//
//  FirebaseImpl.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/26/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import Firebase

class FirebaseImpl:DatabaseDelegate{
    func setupInitialState() {
        FIRApp.configure()
    }
    
    func createUser(name:String?, email: String?, password: String?) {
        guard let email2 = email, let password2 = password, let name2 = name else{
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email2, password: password2, completion: {(user:FIRUser?, error) in
            if error != nil{
                print(error)
                return
            }
            
            guard let uid = user?.uid else{
                return
            }
            
            //successfully authenticated user
            let ref = FIRDatabase.database().reference(fromURL: "https://boostbox-ce76c.firebaseio.com/")
            let usersReference = ref.child("users").child(uid) //opens new directory under unique User ID
            
            let values = ["name":name2,"email":email2]
            usersReference.updateChildValues(values, withCompletionBlock: { (err,ref) in
                if err != nil{
                    print(err)
                    return
                }
                
                print("Saved user successfully into Firebase DB")
                LoginController.own.dismiss(animated: true, completion: nil)
                return
            })
        })
    }
    
    func isLoggedIn()->Bool{
        return !(FIRAuth.auth()?.currentUser == nil)
    }
    
    func signOut() {
        do{
            try FIRAuth.auth()?.signOut()
        }catch let logoutError{
            print(logoutError)
        }
    }
    
    func logIn(email:String?,password:String?){
        guard let email2 = email, let password2 = password else{
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email2, password: password2, completion: {
            (user,error) in
            if error != nil{
                print(error)
                return
            }
            
            LoginController.own.dismiss(animated: true, completion: nil)
        })
    }
    
    func getCurrentUserID()->String?{
        return FIRAuth.auth()?.currentUser?.uid
    }
    
    func getCache(userID:String,completionHandler:@escaping (_ user:Cache?)->()) {
        var userDictionaryRef:[String:AnyObject] = [:]
        var returnUser:Cache? = nil
        
        let uid = userID
        FIRDatabase.database().reference().child("users").child(uid).observe(.value, with: {
            (snapshot) in
            //Load up User from DB
            if let dictionary = snapshot.value as? [String:AnyObject] {
                userDictionaryRef = dictionary
                var image:UIImage = UIImage()
                
                if let profileImageURL = userDictionaryRef["profileURL"]{
                    print("profile")
                    print(profileImageURL)
                    let url = NSURL(string: profileImageURL as! String)
                    
                    URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                        if error != nil{
                            print(error)
                            return
                        }
                        DispatchQueue.main.async {
                            image = UIImage(data:data!)!
                            print("image!!!!")
                            if let gNames = userDictionaryRef["GroupNames"]{
                                let groupNames = (gNames as? [String:String])!
                                var groups:[Group] = []
                                var counter = 0
                                for groupID in groupNames.keys{
                                    self.getGroup(groupID: groupID, completionHandler: {(group:Group?) in
                                        let currentGroup = group
                                        if let currentGroupExists = currentGroup{
                                            counter+=1
                                            groups.append(currentGroupExists)
                                            if counter == groupNames.keys.count{
                                                returnUser = Cache(userID: uid, email: userDictionaryRef["email"]! as! String, name: userDictionaryRef["name"]! as! String, groups:groups, lastUserRevisionTimestamp: Date(),image:image)
                                                
                                                if returnUser == nil{
                                                    completionHandler(nil)
                                                    print("nilled")
                                                }else{
                                                    completionHandler(returnUser)
                                                    print("not nilled")
                                                }
                                            }
                                        }else{
                                            //group not loaded correctly
                                        }
                                    })
                                }
                            }else{
                                returnUser = Cache(userID: uid, email: userDictionaryRef["email"]! as! String, name: userDictionaryRef["name"]! as! String, groups:[], lastUserRevisionTimestamp: Date(),image:image)
                                if returnUser == nil{
                                    completionHandler(nil)
                                    print("nilled")
                                }else{
                                    completionHandler(returnUser)
                                    print("not nilled")
                                }
                            }
                        }
                    }).resume()
                }else{
                    image = #imageLiteral(resourceName: "userBlank")
                    if let gNames = userDictionaryRef["GroupNames"]{
                        let groupNames = (gNames as? [String:String])!
                        var groups:[Group] = []
                        var counter = 0
                        for groupID in groupNames.keys{
                            var group = self.getGroup(groupID: groupID, completionHandler: {(group:Group?) in
                                var currentGroup = group
                                if let currentGroupExists = currentGroup{
                                    counter+=1
                                    groups.append(currentGroupExists)
                                    if counter == groupNames.keys.count{
                                        returnUser = Cache(userID: uid, email: userDictionaryRef["email"]! as! String, name: userDictionaryRef["name"]! as! String, groups:groups, lastUserRevisionTimestamp: Date(),image:image)

                                        if returnUser == nil{
                                            completionHandler(nil)
                                            print("nilled")
                                        }else{
                                            completionHandler(returnUser)
                                            print("not nilled")
                                        }
                                    }
                                }else{
                                    //group not loaded correctly
                                }
                            })
                        }
                    }else{
                        returnUser = Cache(userID: uid, email: userDictionaryRef["email"]! as! String, name: userDictionaryRef["name"]! as! String, groups:[], lastUserRevisionTimestamp: Date(),image:image)
                        if returnUser == nil{
                            completionHandler(nil)
                            print("nilled")
                        }else{
                            completionHandler(returnUser)
                            print("not nilled")
                        }
                    }
                }
            }
            //////
            
            
        }, withCancel: nil)
        
        
    }
    
    func getGroup(groupID:String, completionHandler:@escaping (_ group:Group?)->()){
        var groupDictionaryRef:[String:AnyObject] = [:]
        var returnGroup:Group? = nil
        
        FIRDatabase.database().reference().child("groups").child(groupID).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                groupDictionaryRef = dictionary
                print(groupDictionaryRef)
                
                var membersArray:[GroupMember] = []
                if let members = (groupDictionaryRef["members"] as? [String:AnyObject]){
                    for memberID in members.keys{
                        var stringRole = ""
                        for role in (members[memberID] as? [String:String])!.values{
                            stringRole = role
                        }
                        var role:Position = .member
                        if stringRole == "admin"{
                            role = .admin
                        }
                        var member = GroupMember(userID: memberID, role: role)
                        membersArray.append(member)
                    }
                }
                
                //Placeholder Events Array getter - do when events DB implemented
                if let events = (groupDictionaryRef["events"] as? [String:AnyObject]){
                    var eventsArray:[Event] = []
                    for eventID in events.keys{
                    }
                }
                //
                
                returnGroup = Group(groupID: groupID, groupName: groupDictionaryRef["name"] as! String, groupDescription: groupDictionaryRef["description"] as! String, events: [], members: membersArray)
            }
            
            if returnGroup == nil{
                completionHandler(nil)
            }else{
                completionHandler(returnGroup)
            }
        }, withCancel: nil)
    }
    
    func createGroup(name: String?, description: String?) {
        guard let name2 = name, let description2 = description else{
            return
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://boostbox-ce76c.firebaseio.com/")
        let groupRef = ref.child("groups")
        let newGroupRef = groupRef.childByAutoId()
        
        let values = ["name":name2,"description":description2]
        newGroupRef.setValue(values)
        let membersArrayRef = newGroupRef.child("members")
        
        let newMemberRef = membersArrayRef.child(myCache.currentCache.userID)
        let memberValues = ["role":"admin"]
        newMemberRef.setValue(memberValues)
        
        let userRef = ref.child("users").child(myCache.currentCache.userID).child("GroupNames").child(newGroupRef.key)
        userRef.setValue("placeholderValue")//the key is important. Placeholder is never used.
    }
    
    func joinGroup(groupID:String){
        let ref = FIRDatabase.database().reference(fromURL: "https://boostbox-ce76c.firebaseio.com/")
        let groupRef = ref.child("groups").child(groupID).child("members").child(myCache.currentCache.userID)
        let memberValues = ["role":"member"]
        groupRef.setValue(memberValues)
        
        let userRef = ref.child("users").child(myCache.currentCache.userID).child("GroupNames").child(groupID)
        userRef.setValue("placeholderValue")
    }
    
    func updateProfilePicture(image:UIImage){
        let storageRef = FIRStorage.storage().reference().child("myProfile\(myCache.currentCache.userID)")
        if let uploadData = UIImageJPEGRepresentation(image, 1){
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error)
                    return
                }
                print(metadata)
                let ref = FIRDatabase.database().reference(fromURL: "https://boostbox-ce76c.firebaseio.com/")
                let userRef = ref.child("users").child(myCache.currentCache.userID).child("profileURL")
                userRef.setValue(metadata?.downloadURL()?.absoluteString)
                print("stored")
                
            })
        }
        
    }
    
    func getMiniUser(userID:String, completionHandler:@escaping (_ miniUser:MiniUser?)->()){
        FIRDatabase.database().reference().child("users").child(userID).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let userDictionary = dictionary
                var miniUser:MiniUser = MiniUser()
                
                if let profileImageURL = userDictionary["profileURL"]{
                    let url = NSURL(string: profileImageURL as! String)
                    URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                        if error != nil{
                            print(error)
                            return
                        }
                        DispatchQueue.main.async {
                            let image = UIImage(data:data!)!
                            miniUser = MiniUser(userID: userID, name: userDictionary["name"] as! String, image: image)
                            
                            if miniUser == nil{
                                completionHandler(nil)
                            }else{
                                completionHandler(miniUser)
                            }
                        }
                    }).resume()
                }else{
                    miniUser = MiniUser(userID: userID, name: userDictionary["name"] as! String, image: #imageLiteral(resourceName: "userBlank"))
                    if miniUser == nil{
                        completionHandler(nil)
                    }else{
                        completionHandler(miniUser)
                    }
                }
            }
        }, withCancel: nil)
    }
}
