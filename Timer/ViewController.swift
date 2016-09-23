//
//  ViewController.swift
//  Swift-Acttos
//
//  Created by Actto on 11/8/2016.
//  Copyright © 2016 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let queue: DispatchQueue? = DispatchQueue(label: "GCDTimerQueue", attributes: DispatchQueue.Attributes.concurrent);
    var timer: DispatchSourceTimer? = nil;
    
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
    
    @IBAction func foregroundNSTimerAction(_ sender: AnyObject) {
        self._foregroundTimer();
    }
    
    @IBAction func backgroundNSTimerAction(_ sender: AnyObject) {
        self._backgroundTimer(repeated: false);
    }
    
    @IBAction func repeatedBackgroundNSTimerAction(_ sender: AnyObject) {
        self._backgroundTimer(repeated: true);
    }
    
    @IBAction func gcdTimerAction(_ sender: AnyObject) {
        self._timerInGCD(repeated: false);
    }
    
    @IBAction func repeatedGCDTimerAction(_ sender: AnyObject) {
        self._timerInGCD(repeated: true);
    }
    
    func _foregroundTimer() -> Void {
        Foundation.Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self._foregroundTimerAction(_:)), userInfo: nil, repeats: true);
    }
    
    func _foregroundTimerAction(_ timer: Foundation.Timer) -> Void {
        NSLog("In '_foregroundTimerAction(_:)': The timer is fired.");
    }
    
    func _backgroundTimer(repeated: Bool) -> Void {
        NSLog("_backgroundTimer invoked.");
        /**
         *  The thread I used is a background thread, dispatch_async will set up a background thread to execute the code in the block.
         */
        DispatchQueue.global(qos:.userInitiated).async{
            NSLog("NSTimer will be scheduled...");
            
            //Define a NSTimer
            let timer:Foundation.Timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self._backgroundTimerAction(_:)), userInfo: nil, repeats: repeated);
            //Get the current RunLoop
            let runLoop:RunLoop = RunLoop.current;
            //Add the timer to the RunLoop
            runLoop.add(timer, forMode: RunLoopMode.defaultRunLoopMode);
            //Invoke the run method of RunLoop manually
            runLoop.run();
            NSLog("NSTimer scheduled...");
        }
        
    }
    
    func _backgroundTimerAction(_ timer: Foundation.Timer) -> Void {
        NSLog("In '_backgroundTimerAction(_:)': The timer is fired.");
    }
    
    func _timerInGCD(repeated:Bool) -> Void {
        NSLog("_timerInGCD invoked.");
        if (self.timer != nil) {
            self.timer!.cancel();
        }
        self.timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: queue);
        self.timer?.scheduleRepeating(deadline: .now(), interval: .seconds(1) ,leeway:.milliseconds(0));
        
        self.timer!.setEventHandler(handler: { () -> Void in
            NSLog("In GCD Timer, block is invoked ...");
            
            if(!repeated) {
                self.timer!.cancel();
                NSLog("The timer is canceled.");
            }
        });
        
        NSLog("timer will be resumed.");
        self.timer!.resume();
    }
    
    typealias GCDTimerBlock = @convention(block) (_ userInfo:AnyObject?) -> Void
    
    func scheduledTimerWithTimeInterval(_ ti: Int, block:GCDTimerBlock, repeats yesOrNo: Bool) -> Void {
        if (self.timer != nil) {
            self.timer!.cancel();
        }
        self.timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: queue);
        self.timer?.scheduleRepeating(deadline: .now(), interval: DispatchTimeInterval.seconds(ti) ,leeway:.milliseconds(0));
        
        self.timer!.setEventHandler(handler: { () -> Void in
            NSLog("In GCD Timer, block is invoked ...");
            
            if(!yesOrNo) {
                self.timer!.cancel();
                NSLog("The timer is canceled.");
            }
        });
        
        NSLog("timer will be resumed.");
        timer!.resume();
    }
}

