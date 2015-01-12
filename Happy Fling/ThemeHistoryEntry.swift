//
//  ThemeHistoryEntry.swift
//  Happy Fling
//
//  Created by Ji Hou on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//

import UIKit

class ThemeHistoryEntry: NSObject
{
    var totalThrows:Int = 0
    var successfulThrows:Int = 0
    var failedThrows:Int = 0
    var accuracy:Double = 0.0
    
    //func
    func returnAccuracy() -> Double
    {
        if self.totalThrows != 0
        {
            return Double(self.successfulThrows/self.totalThrows);
        }
        else
        {
            return 0;
        }
        
    }
    
   
}
