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
    var numbers: [CUnsignedLongLong] = [0]
    var fibDirectionUP = true
    var temp = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        while(numbers.count<25){
            self.appendFib()
        }
        
        
        
    }
    
    // MARK:  Fibonacci Methods
    func nextFib() -> Void {
        if((CUnsignedLongLong.max - betaNum) > alphaNum){
            fibNum = alphaNum + betaNum
            alphaNum = betaNum
            betaNum = fibNum
    
        } else{ //Go back down
            fibDirectionUP = false
            betaNum = alphaNum
            println("MAX NUMBER HIT. REVERSE")
        }
    }
    
    func backFib() -> Void {
        if(alphaNum > 0){
            alphaNum = fibNum - betaNum
            fibNum = betaNum
            betaNum = alphaNum
            if(fibNum >= 0){
                alphaNum = fibNum - betaNum
            } else{
                alphaNum = 0
            }
        } else {
            alphaNum = 0
            betaNum = 1
            //numbers.append(1)
            fibNum = 0
            fibDirectionUP = true
            println("REACHED ZERO. REVERSE")
        }
        
    }
    
    func appendFib() -> Void {
        
        if(fibDirectionUP == true){
            self.nextFib()
        } else {
            self.backFib()
        }
        if(fibNum == 1){
            numbers.append(1)
        }
        numbers.append(fibNum)
        
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return swiftBlogs.count
        return 10000
        
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