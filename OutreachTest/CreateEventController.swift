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

class TextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
}

enum EventType{
    case event,deadline
}

enum RepeatType{
    case never,daily,perWeek,perTwoWeek
}

enum AlarmType{
    case none,fiveMin,fifteenMin,thirtyMin,oneHour,twoHour,oneDay,twoDay,oneWeek
}

class EventPackage{
    var eventName:String? = nil
    var eventDescription:String? = nil
    var eventLocation:String? = nil
    var option:EventType = .event
    var timeStart:Date? = nil
    var timeEnd:Date? = nil
    var timeZone:TimeZone = TimeZone.current
    var repeats:RepeatType = .never
    var alarms:[AlarmType] = [.none]
    
    init(){
    
    }
}

class CreateEventController:DatasourceController,UITextFieldDelegate,UITextViewDelegate{
    static var own:CreateEventController?
    var eventPackage:EventPackage = EventPackage()
    
    lazy var eventName:TextField = {
        let text = TextField()
        text.placeholder = "Event Name"
        text.textAlignment = .left
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.delegate = self
        text.backgroundColor = ThemeColor.whitish
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.autocorrectionType = .no
        text.returnKeyType = .done
        text.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return text
    }()
    
    lazy var eventLocation:TextField = {
        let text = TextField()
        text.placeholder = "Event Location"
        text.textAlignment = .left
        text.backgroundColor = ThemeColor.whitish
        text.borderStyle = .none
        text.textColor = ThemeColor.red
        text.delegate = self
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.returnKeyType = .done
        text.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return text
    }()
    
    lazy var eventDescription:UITextView = {
        let text = UITextView()
        text.backgroundColor = ThemeColor.whitish
        text.isEditable = true
        text.text = "Event Description"
        text.textAlignment = .left
        text.textColor = ThemeColor.placeholder
        text.delegate = self
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        text.returnKeyType = .default
        return text
    }()
    
    let timeContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let optionPicker:UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Event","Deadline"])
        sc.tintColor = ThemeColor.whitish
        sc.backgroundColor = ThemeColor.veryLightGray
        sc.layer.cornerRadius = 0
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleOptionChange), for: .valueChanged)
        sc.removeBorders()
        
        let font = UIFont.boldSystemFont(ofSize: 15)
        
        sc.setTitleTextAttributes([NSForegroundColorAttributeName:ThemeColor.red,NSFontAttributeName:font], for: .selected)
        sc.setTitleTextAttributes([NSForegroundColorAttributeName:ThemeColor.lightGray,NSFontAttributeName:font], for: .normal)
        
        return sc
    }()
    
    lazy var dateStart:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseTimeStart))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    let dateStartText:UILabel = {
        let text = UILabel()
        text.text = "Time Start"
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let dateStartIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowDown").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.placeholder
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var dateStartSelectionText:UITextField = {
        let text = UITextField()
        text.isUserInteractionEnabled = false
        text.text = ""
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let dateStartPickerView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    lazy var dateStartPicker:UIDatePicker = {
        let view = UIDatePicker()
        view.backgroundColor = ThemeColor.whitish
        view.addTarget(self, action: #selector(dateStartPicked), for: .valueChanged)
        view.minimumDate = Date()
        return view
    }()
    
    lazy var dateEnd:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseTimeEnd))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    let dateEndText:UILabel = {
        let text = UILabel()
        text.text = "Time End"
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let dateEndIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowDown").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.placeholder
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var dateEndSelectionText:UITextField = {
        let text = UITextField()
        text.isUserInteractionEnabled = false
        text.text = ""
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let dateEndPickerView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    let dateEndPicker:UIDatePicker = {
        let view = UIDatePicker()
        view.backgroundColor = ThemeColor.whitish
        view.addTarget(self, action: #selector(dateEndPicked), for: .valueChanged)
        view.minimumDate = Date()
        return view
    }()
    
    
    lazy var timeZone:UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = ThemeColor.whitish
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseTimeZone))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    let timeZoneIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowRight").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.placeholder
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let timeZoneText:UILabel = {
        let text = UILabel()
        text.text = "Time Zone"
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    lazy var selectedTimeZone:UILabel = {
        let text = UILabel()
        text.text = self.eventPackage.timeZone.identifier.replacingOccurrences(of: "_", with: " ").components(separatedBy: "/").last
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    lazy var repeated:UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = ThemeColor.whitish
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseRepeat))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var selectedRepeat:UILabel = {
        let text = UILabel()
        text.text = self.repeatToText(r: self.eventPackage.repeats)
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let repeatedIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowRight").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.placeholder
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let repeatedText:UILabel = {
        let label = UILabel()
        label.text = "Repeats"
        label.textColor = ThemeColor.placeholder
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var alert:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.whitish
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseAlerts))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var selectedAlert:UILabel = {
        let text = UILabel()
        text.text = self.alertArrayToText(alarms: self.eventPackage.alarms)
        text.backgroundColor = ThemeColor.whitish
        text.textColor = ThemeColor.placeholder
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    
    let alertIcon:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowRight").withRenderingMode(.alwaysTemplate)
        view.tintColor = ThemeColor.placeholder
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let alertText:UILabel = {
        let label = UILabel()
        label.text = "Alerts"
        label.textColor = ThemeColor.placeholder
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let done:UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.veryLightGray
        return view
    }()
    
    let doneLabel:UILabel = {
        let label = UILabel()
        label.text = "Finish"
        label.textColor = ThemeColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    func repeatToText(r:RepeatType)->String{
        switch r{
        case .never:
            return "Never"
        case .daily:
            return "Every Day"
        case .perWeek:
            return "Every Week"
        case .perTwoWeek:
            return "Every 2 Weeks"
        }
    }
    
    func alertArrayToText(alarms:[AlarmType])->String{
        var string = ""
        var counter = 0
        for alarm in alarms{
            switch alarm{
            case .none:
                string+="None"
            case .fiveMin:
                string+="5 mins"
            case .fifteenMin:
                string+="15 mins"
            case .thirtyMin:
                string+="30 mins"
            case .oneHour:
                string+="1 hr"
            case .twoHour:
                string+="2 hr"
            case .oneDay:
                string+="1 day"
            case .twoDay:
                string+="2 day"
            case .oneWeek:
                string+="1 week"
            }
            
            if alarm != .none{
                string+=" before"
            }
            
            if alarms.count > 1 && counter == 0{
                string+=" & "
            }
        
            counter+=1
        }
        return string
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectedTimeZone.text = self.eventPackage.timeZone.identifier.replacingOccurrences(of: "_", with: " ").components(separatedBy: "/").last
        selectedAlert.text = alertArrayToText(alarms: self.eventPackage.alarms)
        selectedRepeat.text = repeatToText(r: self.eventPackage.repeats)
    }
    
    lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.contentSize = CGSize(width:self.view.frame.size.width,height:self.view.frame.size.height*2)
        scroll.frame = self.view.frame
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var scrollViewOverlay:UIView = {
        let view =  UIView()
        view.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height*2)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        CreateEventController.own = self
        
        super.viewDidLoad()
        setupNavigationBarItems()
        view.backgroundColor = ThemeColor.lightGray
        collectionView?.backgroundColor = ThemeColor.lightGray
        
        view.addSubview(scrollView)
        
        let time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(everySecondUpdate), userInfo: nil, repeats: true)
    
        scrollView.addSubview(scrollViewOverlay)
        
        scrollViewOverlay.addSubview(eventName)
        eventName.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 50)
        
        scrollViewOverlay.addSubview(eventLocation)
        eventLocation.anchor(eventName.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 50)
        
        scrollViewOverlay.addSubview(eventDescription)
        eventDescription.anchor(eventLocation.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 100)
        
        scrollViewOverlay.addSubview(timeContainer)
        timeContainer.anchor(eventDescription.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 0)
        timeContainerHeightConstraint = timeContainer.heightAnchor.constraint(equalToConstant: 208)
        timeContainerHeightConstraint?.isActive = true
        
        timeContainer.addSubview(optionPicker)
        optionPicker.anchor(timeContainer.topAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 50)
        
        timeContainer.addSubview(dateStart)
        dateStart.anchor(optionPicker.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 50)
        
        dateStart.addSubview(dateStartText)
        dateStartText.anchor(dateStart.topAnchor, left: dateStart.leftAnchor, bottom: nil, right: nil, topConstant: 25-dateStartText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dateStart.addSubview(dateStartIcon)
        dateStartIcon.anchor(dateStart.topAnchor, left: nil, bottom: nil, right: dateStart.rightAnchor, topConstant: 25-10, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 40, heightConstant: 20)
        
        dateStart.addSubview(dateStartSelectionText)
        dateStartSelectionText.anchor(dateStart.topAnchor, left: nil, bottom: nil, right: dateStartIcon.leftAnchor, topConstant: 25-dateStartSelectionText.intrinsicContentSize.height/2, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        timeContainer.addSubview(dateStartPickerView)
        dateStartPickerView.anchor(dateStart.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 0)
        dateStartViewHeightConstraint = dateStartPickerView.heightAnchor.constraint(equalToConstant: 0)
        dateStartViewHeightConstraint?.isActive = true
        
        dateStartPickerView.addSubview(dateStartPicker)
        dateStartPicker.anchor(dateStartPickerView.topAnchor, left: dateStartPickerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 0)
        
        timeContainer.addSubview(dateEnd)
        dateEnd.anchor(dateStartPickerView.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 0)
        timeEndHeightConstraint = dateEnd.heightAnchor.constraint(equalToConstant: 50)
        timeEndHeightConstraint?.isActive = true
        
        dateEnd.addSubview(dateEndText)
        dateEndText.anchor(dateEnd.topAnchor, left: dateEnd.leftAnchor, bottom: nil, right: nil, topConstant: 25-dateEndText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dateEnd.addSubview(dateEndIcon)
        dateEndIcon.anchor(dateEnd.topAnchor, left: nil, bottom: nil, right: dateEnd.rightAnchor, topConstant: 25-10, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 40, heightConstant: 20)
        
        dateEnd.addSubview(dateEndSelectionText)
        dateEndSelectionText.anchor(dateEnd.topAnchor, left: nil, bottom: nil, right: dateEndIcon.leftAnchor, topConstant: 25-dateEndSelectionText.intrinsicContentSize.height/2, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        timeContainer.addSubview(dateEndPickerView)
        dateEndPickerView.anchor(dateEnd.bottomAnchor, left: timeContainer.leftAnchor , bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 0)
        dateEndViewHeightConstraint = dateEndPickerView.heightAnchor.constraint(equalToConstant: 0)
        dateEndViewHeightConstraint?.isActive = true
        
        dateEndPickerView.addSubview(dateEndPicker)
        dateEndPicker.anchor(dateEndPickerView.topAnchor, left: dateEndPicker.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 0)
        
        timeContainer.addSubview(timeZone)
        timeZone.anchor(dateEndPickerView.bottomAnchor, left: timeContainer.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 50)
        timeZonePadding = timeZone.topAnchor.constraint(equalTo: dateEndPickerView.bottomAnchor, constant: 1)
        timeZonePadding?.isActive = true
        
        timeZone.addSubview(timeZoneText)
        timeZoneText.anchor(timeZone.topAnchor, left: timeZone.leftAnchor, bottom: nil, right: nil, topConstant: 25-timeZoneText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        timeZone.addSubview(timeZoneIcon)
        timeZoneIcon.anchor(timeZone.topAnchor, left: nil, bottom: nil, right: timeZone.rightAnchor, topConstant: 25-20, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 20, heightConstant: 40)
        
        timeZone.addSubview(selectedTimeZone)
        selectedTimeZone.anchor(timeZone.topAnchor, left: nil, bottom: nil, right: timeZoneIcon.leftAnchor, topConstant: 25-selectedTimeZone.intrinsicContentSize.height/2, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        scrollViewOverlay.addSubview(repeated)
        repeated.anchor(timeContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 50)
        
        scrollViewOverlay.addSubview(repeatedIcon)
        repeatedIcon.anchor(repeated.topAnchor, left: nil, bottom: nil, right: repeated.rightAnchor, topConstant: 25-20, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 20, heightConstant: 40)
        
        scrollViewOverlay.addSubview(selectedRepeat)
        selectedRepeat.anchor(repeated.topAnchor, left: nil, bottom: nil, right: repeatedIcon.leftAnchor, topConstant: 25-selectedRepeat.intrinsicContentSize.height/2, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        scrollViewOverlay.addSubview(repeatedText)
        repeatedText.anchor(repeated.topAnchor, left: repeated.leftAnchor, bottom: nil, right: nil, topConstant: 25-repeatedText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        scrollViewOverlay.addSubview(alert)
        alert.anchor(repeated.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 50)
        
        scrollViewOverlay.addSubview(alertIcon)
        alertIcon.anchor(alert.topAnchor, left: nil, bottom: nil, right: alert.rightAnchor, topConstant: 25-20, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 20, heightConstant: 40)
        
        scrollViewOverlay.addSubview(selectedAlert)
        selectedAlert.anchor(alert.topAnchor, left: nil, bottom: nil, right: alertIcon.leftAnchor, topConstant: 25-selectedAlert.intrinsicContentSize.height/2, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        scrollViewOverlay.addSubview(alertText)
        alertText.anchor(alert.topAnchor, left: alert.leftAnchor, bottom: nil, right: nil, topConstant: 25-alertText.intrinsicContentSize.height/2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        scrollViewOverlay.addSubview(done)
        done.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: scrollView.frame.width, heightConstant: 50)
        
        done.addSubview(doneLabel)
        doneLabel.anchor(done.topAnchor, left: done.leftAnchor, bottom: nil, right: nil, topConstant: 25-doneLabel.intrinsicContentSize.height/2, leftConstant: view.frame.width/2-doneLabel.intrinsicContentSize.width/2, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addDoneButtonOnKeyboard()
    }
    
    func dateStartPicked(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL dd, yyyy    h:mm a"
        dateStartSelectionText.text = formatter.string(for: sender.date)
        eventPackage.timeStart = sender.date
        checkFinishColorChange()
    }
    
    func dateStartPickedWOSender(){
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL dd, yyyy    h:mm a"
        dateStartSelectionText.text = formatter.string(for: dateStartPicker.date)
        eventPackage.timeStart = dateStartPicker.date
        checkFinishColorChange()
    }
    
    func dateEndPicked(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL dd, yyyy    h:mm a"
        dateEndSelectionText.text = formatter.string(for: sender.date)
        eventPackage.timeEnd = sender.date
        checkFinishColorChange()
    }
    
    func dateEndPickedWOSender(){
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL dd, yyyy    h:mm a"
        dateEndSelectionText.text = formatter.string(for: dateEndPicker.date)
        eventPackage.timeEnd = dateEndPicker.date
        checkFinishColorChange()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkFinishColorChange()
    }
    
    func textFieldDidChange(){
        checkFinishColorChange()
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        checkFinishColorChange()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == ThemeColor.placeholder {
            textView.text = nil
            textView.textColor = ThemeColor.darkGray
        }
        checkFinishColorChange()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "Group Description (required)"
            textView.textColor = ThemeColor.placeholder
        }
        checkFinishColorChange()
    }
    
    var timeContainerHeightConstraint:NSLayoutConstraint?
    var timeEndHeightConstraint:NSLayoutConstraint?
    var timeZonePadding:NSLayoutConstraint?
    
    var dateStartViewHeightConstraint:NSLayoutConstraint?
    var dateEndViewHeightConstraint:NSLayoutConstraint?
    
    func handleOptionChange(){
        print(self.timeContainerHeightConstraint?.constant)
        
        self.timeContainerHeightConstraint?.constant = self.optionPicker.selectedSegmentIndex == 0 ? (self.timeContainerHeightConstraint?.constant)!+51 : (self.timeContainerHeightConstraint?.constant)!-51 //essentially 208 to 157
        //self.timeContainerHeightConstraint?.constant = self.optionPicker.selectedSegmentIndex == 0 ? 208 : 157
        self.timeEndHeightConstraint?.constant = self.optionPicker.selectedSegmentIndex == 0 ? 50 : 0
        self.timeZonePadding?.constant = self.optionPicker.selectedSegmentIndex == 0 ? 1 : 0
        dateStartText.text = self.optionPicker.selectedSegmentIndex == 0 ? "Time Start" : "Time"
        eventPackage.option = eventPackage.option == .event ? .deadline : .event
        
        self.timeContainerHeightConstraint?.constant = dateEndViewHeightConstraint?.constant == 0 ? (self.timeContainerHeightConstraint?.constant)! : (self.timeContainerHeightConstraint?.constant)! - dateEndPicker.frame.height
        self.dateEndViewHeightConstraint?.constant = 0
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        checkFinishColorChange()
        
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
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.blackOpaque
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(dismissKeyboard))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        doneToolbar.tintColor = ThemeColor.red
        doneToolbar.barTintColor = ThemeColor.veryLightGray
        
        self.eventDescription.inputAccessoryView = doneToolbar
    }
    
    func chooseTimeStart(){
        dateStartPickedWOSender()
        let constant = (self.timeContainerHeightConstraint?.constant)!
        timeContainerHeightConstraint?.constant = dateStartViewHeightConstraint?.constant == 0 ? constant+dateStartPicker.frame.height : constant-dateStartPicker.frame.height
       
        dateStartViewHeightConstraint?.constant = dateStartViewHeightConstraint?.constant == 0 ? dateStartPicker.frame.height : 0
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            let angle = self.dateStartViewHeightConstraint?.constant == 0 ? 0 : CGFloat.pi
            self.dateStartIcon.transform = CGAffineTransform(rotationAngle:angle)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        print("start")
    }
    
    func chooseTimeEnd(){
        dateEndPickedWOSender()
        let constant = (self.timeContainerHeightConstraint?.constant)!
        timeContainerHeightConstraint?.constant = dateEndViewHeightConstraint?.constant == 0 ? constant+dateEndPicker.frame.height : constant-dateEndPicker.frame.height
        
        dateEndViewHeightConstraint?.constant = dateEndViewHeightConstraint?.constant == 0 ? dateEndPicker.frame.height : 0
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            let angle = self.dateEndViewHeightConstraint?.constant == 0 ? 0 : CGFloat.pi
            self.dateEndIcon.transform = CGAffineTransform(rotationAngle:angle)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func chooseRepeat(){
        print("repeat")
        self.navigationController?.pushViewController(ChooseRepeat(), animated: true)
    }
    
    func chooseAlerts(){
        print("alert")
        self.navigationController?.pushViewController(ChooseAlerts(), animated: true)
    }
    
    func chooseTimeZone(){
        print("tz")
        if ChooseTimeZone.own == nil{
            self.navigationController?.pushViewController(ChooseTimeZone(), animated: true)
        }else{
            self.navigationController?.pushViewController(ChooseTimeZone.own!, animated: true)
        }
    }
    
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dismissKeyboard(){
        eventName.resignFirstResponder()
        eventLocation.resignFirstResponder()
        eventDescription.resignFirstResponder()
    }
    
    func checkFinishColorChange(){
        if checkFinishStatus(){
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.done.backgroundColor = ThemeColor.lightGreen
                self.doneLabel.textColor = .black
            }, completion: nil)
            
        }else{
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.done.backgroundColor = ThemeColor.veryLightGray
                self.doneLabel.textColor = ThemeColor.darkGray
            },completion:nil)
        }
    }
    
    func checkFinishStatus()->Bool{
        if !(eventLocation.text?.isEmpty)! && !(eventName.text?.isEmpty)! && !eventDescription.text.isEmpty && eventDescription.textColor != ThemeColor.placeholder && eventPackage.timeStart != nil{
            if eventPackage.option == .deadline{
                if eventPackage.timeStart?.compare(Date()) == .orderedDescending{
                    return true
                }else{
                    return false
                }
            }else{
                if eventPackage.timeEnd != nil{
                    if eventPackage.timeStart?.compare(Date()) == .orderedDescending && eventPackage.timeStart?.compare(eventPackage.timeEnd!) == .orderedAscending{
                        return true
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            }
        }
        return false
    }
    
    func everySecondUpdate(){
        checkFinishColorChange()
    }
}
