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
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var highscoreViewTable: UITableView!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cheerUpLabel: UILabel!
    @IBOutlet weak var hoghscoreViewTable: UITableView!
   
    
    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }

    func setTheme(theme: ThemeClass?) {
        self.theme = theme
    }
  
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        if (theme != nil) {
            backgroundImage.image = UIImage(named: theme.gameEndBackgroundPicture)
        } else {
            backgroundImage.image = UIImage(named: "Background")
        }
        
        backButton.titleLabel?.font = UIFont(name: "Dimitri Swank", size: 130.0)
        cheerUpLabel.font = UIFont (name: "Dimitri Swank", size: 55)
        
        //register cellclass 
        var tableView: UITableView  =   UITableView()
        self.highscoreViewTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.highscoreViewTable.backgroundView?.backgroundColor = UIColor.clearColor()
        highscoreViewTable.backgroundView = nil;
        self.view.addSubview(self.highscoreViewTable)

    }
    
    @IBAction func goToHome(sender: AnyObject) {
        vcc.goToStart()
    }
        
   
   // set number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.highscoreDB.count()
    }
    
    //create cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell:UITableViewCell = self.highscoreViewTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        let entry = self.highscoreDB.getEntry(indexPath.row)
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.blackColor()
    
        cell.backgroundColor = UIColor.clearColor()
        let string1 =  String(indexPath.row + 1) + ": Points: " + String(entry.points) + "    Accuracy: " + String(entry.accuracy)
        let string2 = " %     Succesful Throws: " + String(entry.numberSuccThrows)
        let string3 = " deviation: " + String(entry.deviation) + " points away from bucket"
       
        
        let out = string1 + string2 + string3
        
        cell.textLabel?.font = UIFont(name: "Dimitri Swank", size: 17.0)
        cell.textLabel?.text = out
        
        return cell
        }
    

    
}
