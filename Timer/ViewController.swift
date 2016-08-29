//
//  ViewController.swift
//  Swift-Acttos
//
//  Created by Actto on 11/8/2016.
//  Copyright © 2016 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let queue: dispatch_queue_t? = dispatch_queue_create("GCDTimerQueue", DISPATCH_QUEUE_CONCURRENT);
    var timer: dispatch_source_t? = nil;// = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self._foregroundTimer();
//        self._backgroundTimer(repeated: false);
//        self._backgroundTimer(repeated: true);
//        self._timerInGCD();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func foregroundNSTimerAction(sender: AnyObject) {
        self._foregroundTimer();
    }
    
    @IBAction func backgroundNSTimerAction(sender: AnyObject) {
        self ._backgroundTimer(repeated: false);
    }
    
    @IBAction func repeatedBackgroundNSTimerAction(sender: AnyObject) {
        self ._backgroundTimer(repeated: true);
    }
    
    @IBAction func gcdTimerAction(sender: AnyObject) {
        self._timerInGCD(repeated: false);
    }
    
    @IBAction func repeatedGCDTimerAction(sender: AnyObject) {
        self._timerInGCD(repeated: true);
    }
    
    func _foregroundTimer() -> Void {
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self._foregroundTimerAction(_:)), userInfo: nil, repeats: true);
    }
    
    func _foregroundTimerAction(timer: NSTimer) -> Void {
        NSLog("In '_foregroundTimerAction(_:)': The timer is fired.");
    }
    
    func _backgroundTimer(repeated repeated: Bool) -> Void {
        NSLog("_backgroundTimer invoked.");
        /**
         *  The thread I used is a background thread, dispatch_async will set up a background thread to execute the code in the block.
         */
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            NSLog("NSTimer will be scheduled...");
            
            //Define a NSTimer
            let timer:NSTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self._backgroundTimerAction(_:)), userInfo: nil, repeats: repeated);
            //Get the current RunLoop
            let runLoop:NSRunLoop = NSRunLoop.currentRunLoop();
            //Add the timer to the RunLoop
            runLoop.addTimer(timer, forMode: NSDefaultRunLoopMode);
            //Invoke the run method of RunLoop manually
            runLoop.run();
            NSLog("NSTimer scheduled...");
        }
        
    }
    
    func _backgroundTimerAction(timer: NSTimer) -> Void {
        NSLog("In '_backgroundTimerAction(_:)': The timer is fired.");
    }
    
    func _timerInGCD(repeated repeated:Bool) -> Void {
        NSLog("_timerInGCD invoked.");
        if (self.timer != nil) {
            dispatch_source_cancel(self.timer!);
        }
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer!, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
        
        dispatch_source_set_event_handler(timer!, { () -> Void in
            NSLog("In GCD Timer, block is invoked ...");
            
            if(!repeated) {
                dispatch_source_cancel(self.timer!);
                NSLog("The timer is canceled.");
            }
        });
        
        NSLog("timer will be resumed.");
        dispatch_resume(timer!);
    }
    
    typealias GCDTimerBlock = @convention(block) (userInfo:AnyObject?) -> Void
    
    func scheduledTimerWithTimeInterval(ti: UInt64, block:GCDTimerBlock, repeats yesOrNo: Bool) -> Void {
        if (self.timer != nil) {
            dispatch_source_cancel(self.timer!);
        }
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer!, DISPATCH_TIME_NOW, ti * NSEC_PER_SEC, 0);
        
        dispatch_source_set_event_handler(timer!, { () -> Void in
            NSLog("In GCD Timer, block is invoked ...");
            
            if(!yesOrNo) {
                dispatch_source_cancel(self.timer!);
                NSLog("The timer is canceled.");
            }
        });
        
        NSLog("timer will be resumed.");
        dispatch_resume(timer!);
    }
}

