//
//  ViewController.swift
//  InfiniteFib
//
//  Created by Matthew Kiernan on 7/14/15.
//  Copyright (c) 2015 Matt Kiernan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var alphaNum: CUnsignedLongLong = 0
    var betaNum: CUnsignedLongLong = 1
    var fibNum: CUnsignedLongLong = 0
    var numbers: [CUnsignedLongLong] = [0,1]

//    let swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        while(numbers.count<25){
//            self.nextFib()
//            numbers.append(fibNum)
//            //numbers += fibNum
            
            self.appendFib()
        }
        
        
        
    }
    
    func nextFib() -> Void {
       // if((alphaNum + betaNum) < CUnsignedLongLong.max){
        if((CUnsignedLongLong.max - betaNum) > alphaNum){
            fibNum = alphaNum + betaNum
            alphaNum = betaNum
            betaNum = fibNum
        }
    }
    
    func appendFib() -> Void {
        self.nextFib()
        numbers.append(fibNum)
        
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return swiftBlogs.count
        return 100
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: cellIdentifier)
        }        
        
        let row = indexPath.row

        self.appendFib()
        
       // if((CUnsignedLongLong.max - betaNum) > alphaNum){
            cell!.textLabel?.text = String(numbers[row])
       // }
        
        
        return cell!
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(numbers[row])
    }
}