//
//  GameOverViewController.swift
//  Happy Fling
//
//  Created by Shin on 2015. 1. 23..
//  Copyright (c) 2015년 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit


class GameOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VCCCustomer, ThemeCustomer {



    private var theme: ThemeClass!
    private var vcc: VCC!
    var highscoreDB: DatabaseHighscore = DatabaseHighscore()
    
//    private var points : Int
//    private var time: Int
//    private var accuracy : Double
//    private var succThrows : Int
//    private var unsuccThrows : Int
//    private var numberOfThrows : Int
//    
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var highscoreViewTable: UITableView!
    
    //only testdata
    var highscoredata: [String] = ["1000", "accuracy", "succ. Throws"]
    

    
    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }

    func setTheme(theme: ThemeClass) {
        self.theme = theme
    }
  
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        if (theme != nil) {
            backgroundImage.image = UIImage(named: theme.gameEndBackgroundPicture)
        } else {
            backgroundImage.image = UIImage(named: "Background")
        }

        //register cellclass var tableView: UITableView  =   UITableView()
        self.highscoreViewTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
//         points  = vcc.currentPoints
//         time = vcc.currentTime
//         accuracy = vcc.currentAccuracy
//         succThrows  = vcc.currentSuccThrows
//         unsuccThrows = vcc.currentUnsuccThrows
//         numberOfThrows = succThrows + unsuccThrows
    }
    
    @IBAction func playAgain(sender: AnyObject) {
//            highscoreDB.addScore( vcc.currentPoints, time: vcc.currentTime , accuracy: vcc.currentAccuracy, numberOfThrows: (vcc.currentSuccThrows + vcc.currentUnsuccThrows), numberSuccThrows: vcc.currentSuccThrows)
        vcc.goToGame(theme)
    }
    
    @IBAction func changeTheme(sender: AnyObject) {
//         highscoreDB.addScore( vcc.currentPoints, time: vcc.currentTime , accuracy: vcc.currentAccuracy, numberOfThrows: (vcc.currentSuccThrows + vcc.currentUnsuccThrows), numberSuccThrows: vcc.currentSuccThrows)
        vcc.goToThemeSelection()
    }
    
    @IBAction func goToHome(sender: AnyObject) {
        
//         highscoreDB.addScore( vcc.currentPoints, time: vcc.currentTime , accuracy: vcc.currentAccuracy, numberOfThrows: (vcc.currentSuccThrows + vcc.currentUnsuccThrows), numberSuccThrows: vcc.currentSuccThrows)
        vcc.goToStart()
    }
        
   
   // set number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.highscoredata.count
    }
    
    //create cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.highscoreViewTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        let entry = self.highscoreDB.getEntry(indexPath.row)
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.blackColor()
        //cell.textLabel?.text = "test"
        cell.textLabel?.text = String(indexPath.row + 1) + ": " + String(entry.points) + "  " + String(entry.accuracy)
        return cell
    }
    

    
}
