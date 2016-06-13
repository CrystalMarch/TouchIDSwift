//
//  ViewController.swift
//  TouchIDSwift
//
//  Created by 朱慧平 on 16/6/13.
//  Copyright © 2016年 朱慧平. All rights reserved.
//

import UIKit
import LocalAuthentication
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var button = UIButton()
        button.frame = self.view.bounds
        button.setTitle("Touch Me", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
    }
    func buttonClick(sender:UIButton){
        print("Touch")
        var context = LAContext()
        let result = "Authentication is needed to access your notes."
        var error : NSError?
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: result, reply: { (success :Bool, error :NSError?) in
                if success{
                    print("验证成功")
                }else{
                    print("\(error?.localizedDescription)")
                    switch error!.code{
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by the user")
                    case LAError.UserFallback.rawValue:
                        print("User selected to enter custom password")
                      NSOperationQueue.mainQueue().addOperationWithBlock({ 
//                        用户输入密码，切换主线程处理
                      })
                    default:
                        NSOperationQueue.mainQueue().addOperationWithBlock({ 
//                            其他情况，切换主线程处理
                        })
                        
                    }
                }
            })
        }else{
            switch error!.code {
            case LAError.TouchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled")
            case LAError.PasscodeNotSet.rawValue:
                print("A passcode has not been set")
            default:
                print("TouchID not available")
            }
            print("\(error?.localizedDescription)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

