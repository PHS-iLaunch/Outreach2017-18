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
    static func setupInitialState() {
        FIRApp.configure()
    }
    
    static func createUser(name:String?, email: String?, password: String?) {
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
    
    static func isLoggedIn()->Bool{
        return !(FIRAuth.auth()?.currentUser == nil)
    }
    
    static func signOut() {
        do{
            try FIRAuth.auth()?.signOut()
        }catch let logoutError{
            print(logoutError)
        }
    }
    
    static func logIn(email:String?,password:String?){
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
}
