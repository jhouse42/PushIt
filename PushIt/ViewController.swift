//
//  ViewController.swift
//  PushIt
//
//  Created by Jeanie House on 3/2/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserverForName("Push Touch", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            let x = (notification.userInfo!["x"] as NSString).floatValue
            let y = (notification.userInfo!["y"] as NSString).floatValue
            
            let center = CGPointMake(CGFloat(x), CGFloat(y))
            
            let touchView = UIView(frame: CGRectMake(0,0,0,0))
            touchView.center = center
            touchView.backgroundColor = UIColor.magentaColor()
            
            self.view.addSubview(touchView)
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                touchView.frame = CGRectMake(0, 0, 100, 100)
                touchView.center = center
                touchView.alpha = 0
                
                }, completion: { (success) -> Void in
                     touchView.removeFromSuperview()
                    
            })
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
       // let deviceQuery = PFInstallation.query()
        
        if let touch = touches.allObjects.last as? UITouch {
            
            let location = touch.locationInView(view)
            
            let push = PFPush()
            
            //push.setQuery(deviceQuery)
            //push.setMessage("Hello!")
            
            push.setData(["alert":"Push Touch", "x":"\(location.x)","y":"\(location.y)"])
            
            push.sendPushInBackgroundWithBlock(nil)
            
        }
       
    }
    
}
