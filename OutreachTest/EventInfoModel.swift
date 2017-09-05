//
//  EventInfoModel.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
class EventInfoModel{
    static func editTime(time:String){
        DBFirebase.saveEventTime(groupID: <#T##String#>, eventID: <#T##String#>, time: <#T##String#>)
    }
}
