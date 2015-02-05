//
//  DatabaseHighscore.swift
//  Happy Fling
//
//  Created by Shin on 2015. 1. 19..
//  Copyright (c) 2015년 JJJLM. All rights reserved.
//

import Foundation


struct ScoreEntry {
    var points: NSInteger
    var time : NSInteger
    var accuracy : NSInteger
    var numberOfThrows : NSInteger
    var numberSuccThrows : NSInteger
    var freq : Double
}

@objc class DatabaseHighscore : NSObject {
    
    
//   var themeName: String
    var scoreBoard: Array<ScoreEntry> = Array()
    var databasePath: String
    
    let KEY_POINTS: String = "points" 
    let KEY_TIME: String = "time"
    let KEY_ACCURACY: String = "accuracy"
    let KEY_NUMBEROFTHWORS : String = "numberOfThrows"
    let KEY_NUMBERSUCCTHROWS : String = "numSuccThrows"
    let KEY_FREQUENCY : String = "freq"
    
    
    override init() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let documentsDirectory: AnyObject = paths[0]
        databasePath = documentsDirectory.stringByAppendingPathComponent("highscores.plist")
//       themeName = "defaultName"
//        let path = NSBundle.mainBundle().pathForResource("highscores", ofType: "plist")
        
        let fileManager = NSFileManager.defaultManager()
//        
//        if (!fileManager.fileExistsAtPath(databasePath)) {
//            let fileForCopy = NSBundle.mainBundle().pathForResource("highscores",ofType:"plist")
//            fileManager.copyItemAtPath(fileForCopy!, toPath:databasePath, error: nil)
//        }

        if (!fileManager.fileExistsAtPath(databasePath)) {
            let fileForCopy = NSBundle.mainBundle().pathForResource("highscores",ofType:"plist")
            fileManager.copyItemAtPath(fileForCopy!, toPath:databasePath, error: nil)
        }
        
        let scoreEntries = NSArray(contentsOfFile: databasePath)!
        
        for score in scoreEntries {
            
            let points = score[KEY_POINTS] as NSInteger
            let time = score[KEY_TIME] as NSInteger
            let accuracy = score[KEY_ACCURACY] as NSInteger
            let numberOfThrows = score[KEY_NUMBEROFTHWORS] as NSInteger
            let numberSuccThrows = score[KEY_NUMBERSUCCTHROWS] as NSInteger
            let freq = score[KEY_FREQUENCY] as Double
            
            let scoreEntry = ScoreEntry( points: points, time: time, accuracy: accuracy, numberOfThrows : numberOfThrows, numberSuccThrows: numberSuccThrows, freq: freq);
            scoreBoard.append(scoreEntry)
        }
            scoreBoard.sort({ $0.points > $1.points })
    }
    
    func addScore(points: NSInteger, time: NSInteger, accuracy: NSInteger, numberOfThrows : NSInteger, numberSuccThrows : NSInteger, freq : Double) {
        var newEntry = ScoreEntry(points: points, time: time, accuracy: accuracy, numberOfThrows : numberOfThrows, numberSuccThrows: numberSuccThrows, freq: freq)
        if(scoreBoard.count >= 5) {
            scoreBoard.sort({ $0.points > $1.points })
            scoreBoard.removeLast()
        }
        scoreBoard.append(newEntry)
        commit()
    }
    
    func getEntry(position: NSInteger) -> ScoreEntry {
        return scoreBoard[position]
    }
    
    func getAllEntries() -> Array<ScoreEntry> {
        return scoreBoard;
    }
    
    func getHighScore() -> NSInteger {
        //TODO: clarify which aspect should be used as highscore
        return getEntry(0).points;
      
    }
    
    
    func count() -> Int {
        return scoreBoard.count;
    }
    
    func isEmpty() -> Bool {
        return self.count() == 0;
    }
    
    func commit() {
        var toSave = NSMutableArray()
        for item in scoreBoard {
            var dicChild = NSMutableDictionary()
            dicChild.setValue(item.points, forKey:KEY_POINTS)
            dicChild.setValue(item.time, forKey:KEY_TIME)
            dicChild.setValue(item.accuracy, forKey:KEY_ACCURACY)
            dicChild.setValue(item.numberOfThrows, forKey: KEY_NUMBEROFTHWORS)
            dicChild.setValue(item.numberSuccThrows, forKey: KEY_NUMBERSUCCTHROWS)
            dicChild.setValue(item.freq, forKey: KEY_FREQUENCY)
            toSave.addObject(dicChild)
        }
        if(!toSave.writeToFile(databasePath, atomically:true)) {
            NSLog("ERROR saving");
        }
    }
}