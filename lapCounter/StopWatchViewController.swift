//
//  StopWatchViewController.swift
//  lapCounter
//
//  Created by Yucheng Lin on 2/21/16.
//  Copyright © 2016 Yucheng Lin. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController, GMBLPlaceManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    var timer = NSTimer();
    var lapTimer = NSTimer();
    
    var minutes: Int = 0;
    var seconds: Int = 0;
    var fractions: Int = 0;
    
    var lapMinutes: Int = 0;
    var lapSeconds: Int = 0;
    var lapFractions: Int = 0;
    
    var start:Bool = true;
    var lapFlag:Bool = false;
    var laps = [String]();
   
    @IBOutlet weak var StartButton: UIButton!
    
    @IBOutlet weak var timerFractionLabel: UILabel!
    @IBOutlet weak var timerSecondsLabel: UILabel!
    @IBOutlet weak var timeMinutesLabel: UILabel!
    
    @IBOutlet weak var lapFractionLabel: UILabel!
    @IBOutlet weak var lapSecondsLabel: UILabel!
    @IBOutlet weak var lapMinutesLabel: UILabel!
    
    var placeManager: GMBLPlaceManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        placeManager = GMBLPlaceManager();
        placeManager.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartRun(sender: AnyObject) {
        if(!GMBLPlaceManager.isMonitoring()){
            GMBLPlaceManager.startMonitoring();
        }
        
        else{
            GMBLPlaceManager.stopMonitoring();
        }
        
        startStopTimer();
    }
    
    func placeManager(manager: GMBLPlaceManager, didBeginVisit visit: GMBLVisit){
        print("here");
        if(lapFlag){
            registerLap();
        }
    }
    
    func placeManager(manager: GMBLPlaceManager, didEndVisit visit: GMBLVisit){
        print("Exits");
        if (!lapFlag){
            lapFlag = true;
        }
        
    }
    
    func startStopTimer(){
        if(start == true){
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true);
            lapTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateLap"), userInfo: nil, repeats: true);
            
            start = !start;
            StartButton.setTitle("Pause", forState: UIControlState.Normal);
            
        }
        
        else{
            timer.invalidate();
            lapTimer.invalidate()
            start = !start;
            StartButton.setTitle("Start", forState: UIControlState.Normal);
        }
    }
    
    func registerLap(){
        if (lapFlag){
            // Reset Lap
            lapFractions = 0;
            lapSeconds = 0;
            lapMinutes = 0;
            
            let lapString = "\(lapMinutesLabel.text):\(lapSecondsLabel.text).\(lapFractionLabel.text)"
            laps.insert(lapString, atIndex: 0);
            lapFractionLabel.text = "00";
            lapSecondsLabel.text = "00";
            lapMinutesLabel.text = "00";
            lapTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateLap"), userInfo: nil, repeats: true);
            lapFlag = false;
        }
    }
    
    func updateTimer(){
        fractions += 1;
        
        if(fractions == 100){
            seconds += 1;
            fractions = 0;
        }
        
        if(seconds == 60){
            minutes += 1;
            seconds = 1;
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)";
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)";
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)";
        timerFractionLabel.text = fractionsString;
        timerSecondsLabel.text = secondsString;
        timeMinutesLabel.text = minutesString;
    }
    
    func updateLap(){
        lapFractions += 1;
    
        if(lapFractions == 100){
            lapSeconds += 1;
            lapFractions = 0;
        }
    
        if(lapSeconds == 60){
            lapMinutes += 1;
            lapSeconds = 1;
        }
    
        let fractionsString = lapFractions > 9 ? "\(lapFractions)" : "0\(lapFractions)";
        let secondsString = lapSeconds > 9 ? "\(lapSeconds)" : "0\(lapSeconds)";
        let minutesString = lapMinutes > 9 ? "\(lapMinutes)" : "0\(lapMinutes)";
        lapFractionLabel.text = fractionsString;
        lapSecondsLabel.text = secondsString;
        lapMinutesLabel.text = minutesString;
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
