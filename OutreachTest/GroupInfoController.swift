//
//  GroupInfoController.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/3/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupInfoController:DatasourceController{
    var group:Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = ThemeColor.whitish
        setupNavigationBarItems()
        print(group.groupName)
        print(group.groupDescription)
        
    }
    
    init(groupID:String){
        for incrementalGroup in myCache.currentCache.groups{
            if incrementalGroup.groupID == groupID{
                group = incrementalGroup
            }
        }
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavigationBarItems(){
        let joinGroupLabel = UILabel()
        joinGroupLabel.text = group.groupName
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