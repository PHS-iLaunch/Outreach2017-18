//
//  JoinGroupController.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/2/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

class JoinGroupController:UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    var video = AVCaptureVideoPreviewLayer()
    var session = AVCaptureSession()
    static var own:JoinGroupController?
    var currentDetectedGroup:Group? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let group = currentDetectedGroup{
            self.session.stopRunning()
            
            let alert = UIAlertController(title: "Group Code Detected", message: "Join \(group.groupName)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Join", style: .default, handler: {(nil) in
                
            }))
            alert.addAction(UIAlertAction(title: "View Group", style: .default, handler: {(nil) in
                JoinGroupController.own?.present(UINavigationController(rootViewController: GroupInfoController(group:group)), animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(nil) in
                self.session.startRunning()
            }))
            
            self.present(alert,animated:false,completion: nil)
        }else{
            session.startRunning()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        view.backgroundColor = ThemeColor.whitish
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }catch{
            
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
        JoinGroupController.own = self
    }
    
    func captureOutput(_ output: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObjectTypeQRCode{
                    DatabaseFactory.DB.getGroup(groupID: object.stringValue, completionHandler: {(group:Group?) in
                        let currentGroup = group
                        if let currentGroupExists = currentGroup{
                            var isJoinedAlready = false
                            for group in myCache.currentCache.groups{
                                if group.groupID == currentGroupExists.groupID{
                                    isJoinedAlready = true
                                }
                            }
                            if !isJoinedAlready{
                                print(currentGroupExists.groupName)
                                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                                self.session.stopRunning()
                                
                                let alert = UIAlertController(title: "Group Code Detected", message: "Join \(currentGroupExists.groupName)?", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Join", style: .default, handler: {(nil) in
                                    
                                }))
                                alert.addAction(UIAlertAction(title: "View Group", style: .default, handler: {(nil) in
                                    self.currentDetectedGroup = currentGroupExists
                                    JoinGroupController.own?.present(UINavigationController(rootViewController: GroupInfoController(group:currentGroupExists)), animated: true, completion: nil)
                                }))
                                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(nil) in
                                    self.session.startRunning()
                                }))
                                
                                self.present(alert,animated:true,completion: nil)
                                
                            }
                        }else{
                            print("Not a group")//group not loaded correctly
                        }
                    })
                }
            }
        }
    }
    
    func setupNavigationBarItems(){
        let joinGroupLabel = UILabel()
        joinGroupLabel.text = "Join a Group"
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
