//
//  ProfileController.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/4/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class ProfileController:DatasourceController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var otherProfileCache = Cache()
    var userOtherCache = false
    static var own:ProfileController?
    
    lazy var profilePicBackView:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ThemeColor.veryLightGray
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height/3)
        view.image = #imageLiteral(resourceName: "wallpaper")
        return view
    }()
    
    lazy var profilePic:UIImageView = {
        let view = UIImageView()
        view.image = self.otherProfileCache.profilePic
        view.frame.size = CGSize(width:view.frame.height/4,height:view.frame.height/4)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = self.view.frame.height/8
        view.layer.masksToBounds = true
        return view
    }()
    
    var profileWidthConstraint:NSLayoutConstraint?
    var profileHeightConstraint:NSLayoutConstraint?
    
    var profilePicButtonView:UIView = UIView()
    var viewHeight:CGFloat = 0
    var viewWidth:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        view.backgroundColor = ThemeColor.whitish
        
        
        view.addSubview(profilePicBackView)
        profilePicBackView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height/3)
        
        let darkOverlay = UIView()
        darkOverlay.backgroundColor = .black
        darkOverlay.alpha = 0.5
        view.addSubview(darkOverlay)
        darkOverlay.anchor(profilePicBackView.topAnchor, left: profilePicBackView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height/3)
        
        view.addSubview(profilePic)
        profilePic.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: view.frame.height/6-view.frame.height/8, leftConstant: view.frame.width/2-view.frame.height/8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        profileWidthConstraint = profilePic.widthAnchor.constraint(equalToConstant: view.frame.height/4.0)
        profileWidthConstraint?.isActive = true
        profileHeightConstraint = profilePic.heightAnchor.constraint(equalToConstant: view.frame.height/4.0)
        profileHeightConstraint?.isActive = true
        
        profilePicButtonView.frame = CGRect(x: view.frame.width/2-view.frame.height/8, y: view.frame.height/6-view.frame.height/8, width: view.frame.height/4.0, height: view.frame.height/4.0)
        profilePicButtonView.layer.cornerRadius = self.view.frame.height/8
        profilePicButtonView.backgroundColor = .clear
        profilePicButtonView.alpha = 0.25
        view.addSubview(profilePicButtonView)
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.profileTap(tap:)))
        profilePicButtonView.addGestureRecognizer(gestureTap)
        viewHeight = view.frame.height
        viewWidth = view.frame.width
        
        view.addSubview(editProfilePic)
        editProfilePic.isHidden = true
        editProfilePic.frame = CGRect(x: self.viewWidth/2+(self.viewHeight/8-(self.viewHeight/4-self.viewHeight/5)*2), y: self.viewHeight/6-self.viewHeight/10+self.viewHeight/5*0.75, width: (self.viewHeight/4-self.viewHeight/5)*1.5, height: (self.viewHeight/4-self.viewHeight/5)*1.5)
        editProfilePic.layer.cornerRadius = ((self.viewHeight/4-self.viewHeight/5)/2)*1.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.takePhoto(tap:)))
        editProfilePic.isUserInteractionEnabled = true
        editProfilePic.addGestureRecognizer(tap)
        
        ProfileController.own = self
    }
    
    lazy var editProfilePic:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ThemeColor.veryLightGray
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "editProfileImage")
        return view
    }()
    
    func takePhoto(tap:UITapGestureRecognizer){
        print("photo")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Update Your Profile Picture", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                imagePickerController.allowsEditing = false
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                //Camera Not Available
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action:UIAlertAction) in
            
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            DatabaseFactory.DB.updateProfilePicture(image: editedImage)
            handleProfileTap()
            profilePic.image = editedImage
            return
        }
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            DatabaseFactory.DB.updateProfilePicture(image: image)
            handleProfileTap()
            profilePic.image = image
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        handleProfileTap()
    }
    
    func handleProfileTap(){
        if !userOtherCache{
            if self.profileHeightConstraint?.constant == self.viewHeight/4{
                editProfilePic.isHidden = false
            }else{
                editProfilePic.isHidden = true
            }
            
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations:{
                if self.profileHeightConstraint?.constant == self.viewHeight/4{
                    self.profileHeightConstraint?.constant = self.viewHeight/5
                    self.profileWidthConstraint?.constant = self.viewHeight/5
                    self.profilePic.layer.cornerRadius = self.viewHeight/10
                    self.profilePicButtonView.layer.cornerRadius = self.viewHeight/10
                    self.profilePicButtonView.backgroundColor = .clear
                    //self.profilePic.transform = CGAffineTransform(rotationAngle:-CGFloat.pi/8.0)
                    self.profilePicButtonView.frame = CGRect(x: self.viewWidth/2-self.viewHeight/8, y: self.viewHeight/6-self.viewHeight/8, width: self.viewHeight/5, height: self.viewHeight/5)
                }else{
                    print((self.profileHeightConstraint?.constant)!/self.view.frame.height)
                    print(self.view.frame.height)
                    self.profileHeightConstraint?.constant = self.viewHeight/4
                    self.profileWidthConstraint?.constant = self.viewHeight/4
                    //self.profilePic.transform = CGAffineTransform(rotationAngle:0)
                    self.profilePic.layer.cornerRadius = self.viewHeight/8
                    self.profilePicButtonView.layer.cornerRadius = self.viewHeight/8
                    self.profilePicButtonView.backgroundColor = .clear
                    self.profilePicButtonView.frame = CGRect(x: self.viewWidth/2-self.viewHeight/8, y: self.viewHeight/6-self.viewHeight/8, width: self.viewHeight/4, height: self.viewHeight/4)
                }
            },completion:nil)
        }
    }
    
    func profileTap(tap:UITapGestureRecognizer){
        handleProfileTap()
    }
    
    var joinGroupLabel = UILabel()
    
    func setupNavigationBarItems(){
        if userOtherCache{
            joinGroupLabel.text = ""
        }else{
            joinGroupLabel.text = "My Profile"
        }
        joinGroupLabel.textColor = ThemeColor.whitish
        joinGroupLabel.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = joinGroupLabel
        
        let label = UILabel()
        label.text = "adsfadsf"
        //navigationItem.titleView = label
        
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "x").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:backButton)
        
        navigationController?.navigationBar.barTintColor = ThemeColor.red
        let bounds = self.navigationController!.navigationBar.bounds
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height*1.5)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    init(userID:String) {
        super.init()
        if userID != myCache.currentCache.userID{
            userOtherCache = true
            var currentCache:Cache? = Cache()
            DatabaseFactory.DB.getCache(userID: userID, completionHandler: { (cache:Cache?) in
                //code called after data loaded
                print("cache received")
                currentCache = cache
                if let currentCacheExists = currentCache{
                    self.otherProfileCache = currentCacheExists
                    print("ProfileName:\(self.otherProfileCache.name)")
                    self.joinGroupLabel.text = self.otherProfileCache.name
                    self.joinGroupLabel.frame.size = self.joinGroupLabel.intrinsicContentSize
                    self.navigationItem.titleView = self.joinGroupLabel
                    print(self.navigationItem.titleView?.frame)
                    
                    self.profilePic.image = self.otherProfileCache.profilePic
                }else{
                    //Some Network Error
                }
                //
            })
        }else{
            self.otherProfileCache = myCache.currentCache
        }
        //turn userID into UserPackage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
