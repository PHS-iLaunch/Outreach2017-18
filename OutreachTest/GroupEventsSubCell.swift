//
//  GroupEventsSubCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/5/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupEventsHeader:DatasourceCell{
    
    let addLabel:UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.popBlue
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Add Event"
        return label
    }()
    
    let addIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "newGroup").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.popBlue
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
        addSubview(addLabel)
        addLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: self.frame.height/2-addLabel.intrinsicContentSize.height/2, leftConstant: self.frame.width/2-addLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addSubview(addIcon)
        addIcon.anchor(self.topAnchor, left: nil, bottom: nil, right: addLabel.leftAnchor, topConstant: self.frame.height/2-10, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 20, heightConstant: 20)
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.add(tap:)))
        self.addGestureRecognizer(gestureTap)
    }
    
    func add(tap:UITapGestureRecognizer){
        GroupInfoController.own.present(UINavigationController(rootViewController:CreateEventController()), animated: true, completion: nil)
    }
}

class GroupEventsSubCell:DatasourceCell{
    
    override var datasourceItem: Any?{
        didSet{
            var event:Event = (datasourceItem as? Event)!
        }
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
    }
}
