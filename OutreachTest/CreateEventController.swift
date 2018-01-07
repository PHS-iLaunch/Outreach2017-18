//
//  CreateEventController.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/7/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class CreateEventController:DatasourceController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        view.backgroundColor = ThemeColor.whitish
    }
    
    func setupNavigationBarItems(){
        let joinGroupLabel = UILabel()
        joinGroupLabel.text = "Create a New Event"
        joinGroupLabel.textColor = ThemeColor.whitish
        joinGroupLabel.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = joinGroupLabel
        
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
}
