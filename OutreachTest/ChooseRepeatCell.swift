//
//  ChooseRepeatCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/9/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class ChooseRepeatCell:DatasourceCell{
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.red
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "j"
        return label
    }()
    
    override var datasourceItem: Any?{
        didSet{
            let a = (datasourceItem as? String)!
            
            label.text = a
            label.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: frame.height/2-label.intrinsicContentSize.height/2, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            
            var matchText = ""
            switch (CreateEventController.own?.eventPackage.repeats)!{
            case .never:
                matchText = ChooseRepeatDatasource.labelArray[0]
            case .daily:
                matchText = ChooseRepeatDatasource.labelArray[1]
            case .perWeek:
                matchText = ChooseRepeatDatasource.labelArray[2]
            case .perTwoWeek:
                matchText = ChooseRepeatDatasource.labelArray[3]
            }
            
            if matchText == a{
                backgroundColor = ThemeColor.red
                label.textColor = ThemeColor.whitish
            }else{
                backgroundColor = ThemeColor.whitish
                label.textColor = ThemeColor.red
            }
        }
    }
    
    func add(tap:UITapGestureRecognizer){
        var repeatType:RepeatType = .never
        switch label.text! {
        case ChooseRepeatDatasource.labelArray[0]:
            repeatType = .never
        case ChooseRepeatDatasource.labelArray[1]:
            repeatType = .daily
        case ChooseRepeatDatasource.labelArray[2]:
            repeatType = .perWeek
        case ChooseRepeatDatasource.labelArray[3]:
            repeatType = .perTwoWeek
        default:
            repeatType = .never
        }
        CreateEventController.own?.eventPackage.repeats = repeatType
        ChooseRepeat.own?.navigationController?.popViewController(animated: true)
        ChooseRepeat.own?.collectionView?.reloadData()
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(label)
        backgroundColor = ThemeColor.whitish
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.add(tap:)))
        self.addGestureRecognizer(gestureTap)
    }
}
