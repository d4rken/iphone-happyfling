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
    }
    
    @IBAction func playAgain(sender: AnyObject) {
        vcc.goToGame(theme)
    }
    
    @IBAction func changeTheme(sender: AnyObject) {
        vcc.goToThemeSelection()
    }
    
    @IBAction func goToHome(sender: AnyObject) {
        vcc.goToStart()
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
