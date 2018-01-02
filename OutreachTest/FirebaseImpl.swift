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
    
    func getCache(completionHandler:@escaping (_ user:Cache?)->()) {
        var userDictionaryRef:[String:AnyObject] = [:]
        var returnUser:Cache? = nil
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: {
            (snapshot) in
            //Load up User from DB
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    userDictionaryRef = dictionary
                    returnUser = Cache(userID: uid!, email: userDictionaryRef["email"]! as! String, name: userDictionaryRef["name"]! as! String, groups: [], lastUserRevisionTimestamp: Date())
                }
            //////
            if returnUser == nil{
                completionHandler(nil)
            }else{
                completionHandler(returnUser)
            }
            
        }, withCancel: nil)
    }
}
