//
//  RunSession.swift
//  lapCounter
//
//  Created by Yucheng Lin on 2/21/16.
//  Copyright © 2016 Yucheng Lin. All rights reserved.
//

import UIKit

class RunSession: NSObject {
    var totalLaps:Int{
        return self.laps.count;
    };
    var date = NSDate();
    var totalTime:NSTimeInterval{
        var total:NSTimeInterval = 0.0;
        for lap in laps {
            total += lap
        }
        return total;
    };
    var laps = [NSTimeInterval]();
    var distancePerLap: Double?
    var totalDistance:Double?{
        return Double(self.totalLaps) * self.distancePerLap!;
    }
    
    init(laps: [NSTimeInterval]){
        self.laps = laps;
    }
    
    func setLapDistance(distancePerLap:Double){
        self.distancePerLap = distancePerLap;
    }
    
}
