//
//  ChooseAlertCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/9/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class ChooseAlertCell:DatasourceCell{
    
    var isChosen = false
    
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
            
            var chosen:[String] = []
            for alarm in (CreateEventController.own?.eventPackage.alarms)!{
                switch alarm{
                case .none:
                    chosen.append(ChooseAlertDatasource.labelArray[0])
                case .fiveMin:
                    chosen.append(ChooseAlertDatasource.labelArray[1])
                case .fifteenMin:
                    chosen.append(ChooseAlertDatasource.labelArray[2])
                case .thirtyMin:
                    chosen.append(ChooseAlertDatasource.labelArray[3])
                case .oneHour:
                    chosen.append(ChooseAlertDatasource.labelArray[4])
                case .twoHour:
                    chosen.append(ChooseAlertDatasource.labelArray[5])
                case .oneDay:
                    chosen.append(ChooseAlertDatasource.labelArray[6])
                case .twoDay:
                    chosen.append(ChooseAlertDatasource.labelArray[7])
                case .oneWeek:
                    chosen.append(ChooseAlertDatasource.labelArray[8])
                default:
                    print("something wrong")
                }
            }
            
            var isSelected = false
            for item in chosen{
                if a == item{
                    isSelected = true
                }
            }
            isChosen = isSelected
            if isSelected{
                backgroundColor = ThemeColor.red
                label.textColor = ThemeColor.whitish
            }else{
                backgroundColor = ThemeColor.whitish
                label.textColor = ThemeColor.red
            }
        }
    }
    
    func add(tap:UITapGestureRecognizer){
        var alarm:AlarmType = .none
        switch label.text!{
        case ChooseAlertDatasource.labelArray[0]:
            alarm = .none
        case ChooseAlertDatasource.labelArray[1]:
            alarm = .fiveMin
        case ChooseAlertDatasource.labelArray[2]:
            alarm = .fifteenMin
        case ChooseAlertDatasource.labelArray[3]:
            alarm = .thirtyMin
        case ChooseAlertDatasource.labelArray[4]:
            alarm = .oneHour
        case ChooseAlertDatasource.labelArray[5]:
            alarm = .twoHour
        case ChooseAlertDatasource.labelArray[6]:
            alarm = .oneDay
        case ChooseAlertDatasource.labelArray[7]:
            alarm = .twoDay
        case ChooseAlertDatasource.labelArray[8]:
            alarm = .oneWeek
        default:
            alarm = .none
        }
        if !isChosen{
            if alarm == .none{
                CreateEventController.own?.eventPackage.alarms = [.none]
                ChooseAlerts.own?.isNoneThere = true
            }else{
                if (ChooseAlerts.own?.isNoneThere)!{
                    let index = (CreateEventController.own?.eventPackage.alarms.index(of: .none))!
                    CreateEventController.own?.eventPackage.alarms.remove(at:index)
                    ChooseAlerts.own?.isNoneThere = false
                    
                    if (CreateEventController.own?.eventPackage.alarms.count)! < 2{
                        CreateEventController.own?.eventPackage.alarms.append(alarm)
                    }
                }else{
                    if (CreateEventController.own?.eventPackage.alarms.count)! < 2{
                        CreateEventController.own?.eventPackage.alarms.append(alarm)
                    }
                }
            }
            
            if (CreateEventController.own?.eventPackage.alarms.count)! == 2 || (ChooseAlerts.own?.isNoneThere)!{
                ChooseAlerts.own?.navigationController?.popViewController(animated: true)
            }
        }else{
            let index = (CreateEventController.own?.eventPackage.alarms.index(of: alarm))!
            CreateEventController.own?.eventPackage.alarms.remove(at: index)
            
            if alarm == .none{
                ChooseAlerts.own?.isNoneThere = false
            }
            
            if (CreateEventController.own?.eventPackage.alarms.count)! == 0{
                CreateEventController.own?.eventPackage.alarms.append(.none)
                ChooseAlerts.own?.isNoneThere = true
            }
            
            if (ChooseAlerts.own?.isNoneThere)!{
                ChooseAlerts.own?.navigationController?.popViewController(animated: true)
            }
        }
        ChooseAlerts.own?.collectionView?.reloadData()
        
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(label)
        backgroundColor = ThemeColor.whitish
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.add(tap:)))
        self.addGestureRecognizer(gestureTap)
    }
}
