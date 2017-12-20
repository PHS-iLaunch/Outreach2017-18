//
//  Calendar.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/20/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

class myCalendar{
    static func getDay()->Int{//Return the date in the month
        return Calendar.current.component(.day, from: Date())
    }
    
    static func getMonth()->Int{
        return Calendar.current.component(.month, from: Date())
    }
    
    static func getYear()->Int{
        return Calendar.current.component(.year, from: Date())
    }
    
    static func getDayOfWeek()->Int{
        return Calendar.current.component(.weekday, from: Date())
    }
    
    static func getDayOfWeekGivenDate(month:Int, date:Int, year:Int)->Int{
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = date
        dateComponents.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        dateComponents.hour = 8 //arbitrary
        dateComponents.minute = 34 //arbitrary
        return Calendar.current.component(.weekday, from: Calendar.current.date(from: dateComponents)!)
    }
    
    static func getNumberOfDaysInMonth(month:Int,year:Int)->Int{
        let dateComponents = DateComponents(year: year, month: month)
        let date = Calendar.current.date(from: dateComponents)!
        
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        return range.count
    }
}
