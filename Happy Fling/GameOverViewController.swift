//
//  GameOverViewController.swift
//  Happy Fling
//
//  Created by Shin on 2015. 1. 23..
//  Copyright (c) 2015년 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit




class GameOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  , VCCCustomer, ThemeCustomer {
    
    private var vcc: VCC!
    private var theme: ThemeClass!
    
    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }

    func setTheme(theme: ThemeClass) {
        self.theme = theme
    }
    
    //TODO: func to store the data into the database
    
    //only testdata
    var highscoredata: [String] = ["1000", "accuracy", "succ. Throws"]
    
    @IBOutlet weak var highscoreViewTable: UITableView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
//        backgroundImage.image = UIImage(named: "Background")
        
        //register cellclass var tableView: UITableView  =   UITableView()
        self.highscoreViewTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    @IBAction func playAgain(sender: AnyObject) {
        self.performSegueWithIdentifier("gameOverToGameViewController", sender: self)
        
    }
    
    @IBAction func changeTheme(sender: AnyObject) {
        self.performSegueWithIdentifier("GameOverToThemeSelection", sender: self)
    }
    
    @IBAction func goToHome(sender: AnyObject) {
        self.performSegueWithIdentifier("GameOverToMain", sender: self)
    }
        
   
   // set number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.highscoredata.count
    }
    
    //create cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.highscoreViewTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.highscoredata[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}
