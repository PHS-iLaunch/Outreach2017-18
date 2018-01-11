//
//  ChooseTimeZoneCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/9/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class ChooseTimeZoneCell:DatasourceCell{
    var id:String = ""
    var itemNum:Int = 0
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.red
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = ""
        return label
    }()
    
    override var datasourceItem: Any?{
        didSet{
            let a = (datasourceItem as? [String])!
            id = a[0]
            
            let text = id.replacingOccurrences(of: "/", with: " - ")
            let text2 = text.replacingOccurrences(of: "_", with: " ")
            
            label.text = text2
            
            if a[1] == id{
                backgroundColor = ThemeColor.red
                label.textColor = ThemeColor.whitish
            }else{
                backgroundColor = ThemeColor.whitish
                label.textColor = ThemeColor.red
            }
            
            label.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: frame.height/2-label.intrinsicContentSize.height/2, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            
            itemNum = Int(a[2])!
        }
    }
    
    func add(tap:UITapGestureRecognizer){
        CreateEventController.own?.eventPackage.timeZone = TimeZone(identifier: id)!
        ChooseTimeZone.own?.navigationController?.popViewController(animated: true)
        ChooseTimeZone.own?.collectionView?.reloadData()
        ChooseTimeZone.own?.selectedIndex = itemNum
        
        //Update UTC times of dates
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(label)
        backgroundColor = ThemeColor.whitish
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.add(tap:)))
        self.addGestureRecognizer(gestureTap)
    }
}
