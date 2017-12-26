//
//  LoginController.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/26/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController{
    
    let inputContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        //button.backgroundColor = ThemeColor.brightMagenta
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    func handleSignIn(){
        DatabaseFactory.createUser(name:nameTextField.text, email: emailTextField.text, password: passwordTextField.text)
    }
    
    let nameTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        return tf
    }()
    
    let nameSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.lightGray
        return view
    }()
    
    let emailTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        return tf
    }()
    
    let emailSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.lightGray
        return view
    }()
    
    let passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password (at least 6 characters)"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = ThemeColor.red
        
        let logo = UIImageView(image: #imageLiteral(resourceName: "BoostboxWhite"))
        view.addSubview(logo)
        logo.contentMode = .scaleAspectFill
        logo.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: nil, topConstant: view.frame.height/6, leftConstant: view.frame.width/3, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width/3, heightConstant: view.frame.width/3)
        
        view.addSubview(inputContainerView)
        inputContainerView.anchor(logo.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width-24, heightConstant: 150)
        
        inputContainerView.addSubview(nameTextField)
        nameTextField.anchor(inputContainerView.topAnchor, left: inputContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width-48, heightConstant: 50)
        
        inputContainerView.addSubview(nameSeparatorView)
        nameSeparatorView.anchor(nameTextField.bottomAnchor, left: inputContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width-24, heightConstant: 1)
        
        inputContainerView.addSubview(emailTextField)
        emailTextField.anchor(nameSeparatorView.bottomAnchor, left: inputContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width-48, heightConstant: 50)
        
        inputContainerView.addSubview(emailSeparatorView)
        emailSeparatorView.anchor(emailTextField.bottomAnchor, left: inputContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width-24, heightConstant: 1)
        
        inputContainerView.addSubview(passwordTextField)
        passwordTextField.anchor(emailSeparatorView.bottomAnchor, left: inputContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width-48, heightConstant: 50)
        
        view.addSubview(loginRegisterButton)
        loginRegisterButton.anchor(inputContainerView.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width-24, heightConstant: 50)
    }
    
    
}
