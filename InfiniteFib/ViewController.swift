//
//  ViewController.swift
//  InfiniteFib
//
//  Created by Matthew Kiernan on 7/14/15.
//  Copyright (c) 2015 Matt Kiernan. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    @IBOutlet var tableView: UITableView!
    
//    var alphaNum: CUnsignedLongLong = 0
//    var betaNum: CUnsignedLongLong = 1
//    var fibNum: CUnsignedLongLong = 0
//    var numbers: [CUnsignedLongLong] = [0]
//    var fibDirectionUP = true
    
    var MAXPLACEHOLDER: CUnsignedLongLong = 10000000000000000000
    var fibAlpha: CUnsignedLongLong = 0
    var fibBeta: CUnsignedLongLong = 0
    var alpha1: CUnsignedLongLong = 0
    var alpha2: CUnsignedLongLong = 0
    var beta1: CUnsignedLongLong = 0
    var beta2: CUnsignedLongLong = 1
    var temp1: CUnsignedLongLong = 0
    var temp2: CUnsignedLongLong = 0
    var numbers1: [CUnsignedLongLong] = [0,0]
    var numbers2: [CUnsignedLongLong] = [0,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        while(numbers2.count<25){ //loads 25 fibonacci numbers to the 'numbers' array on load
            self.appendFib()
        }
        
        
        
    }
    
    // MARK:  Fibonacci Methods
    func nextFib() -> Void { //Finds next Fibonacci number
        
        //***** LARGEST POSSIBLE FIBONACCI NUMBER ON IOS(ULL): 12200160415121876738 ******//
        
//        if((CUnsignedLongLong.max - betaNum) > alphaNum){
        /*
            fibNum = alphaNum + betaNum
            alphaNum = betaNum
            betaNum = fibNum
        */
    
//        } else{ //Go back down
//            fibDirectionUP = false
//            betaNum = alphaNum
//            println("MAX NUMBER HIT. REVERSE")
//        }
        
        temp1 = fibAlpha
        temp2 = fibBeta
       if((CUnsignedLongLong.max - beta1) > alpha1){
        fibAlpha = alpha1 + beta1
        fibBeta = alpha2 + beta2
        
//        beta2 = alpha2
//        beta1 = alpha1
//        
//        alpha2 = temp2
//        alpha1 = temp1
        
        alpha1 = beta1
        alpha2 = beta2
        
        beta2 = fibBeta
        beta1 = fibAlpha
        
        self.splitFib()
        self.splitAlpha()
        self.splitBeta()
       }
        
    }

/*
    func backFib() -> Void { //Finds previous Fibonacci number
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
            fibNum = 0
            
            //Go back up
            
            fibDirectionUP = true
            println("REACHED ZERO. REVERSE")
        }
        
    }
*/
    
    //Adds Fibonacci number to 'numbers' array
    func appendFib() -> Void {
        
//        if(fibDirectionUP == true){
            self.nextFib()
//        } else {
//            self.backFib()
//        }
//        if(fibNum == 1){    //Adds the "extra" '1' for the series
//            numbers.append(1)
//        }
      //  numbers.append(fibNum)
        
        numbers2.append(fibBeta)
        numbers1.append(fibAlpha)
        
    }
    
    func splitFib() -> Void {
//        if(fibNum >= MAXPLACEHOLDER){
//            
//        }
        
        fibAlpha += fibBeta/MAXPLACEHOLDER
        fibBeta -= (fibBeta/MAXPLACEHOLDER)*MAXPLACEHOLDER
    }
    

    func splitAlpha() -> Void {
        alpha1 += alpha2/MAXPLACEHOLDER
        alpha2 -= (alpha2/MAXPLACEHOLDER)*MAXPLACEHOLDER
    }
    
    func splitBeta() -> Void {
        beta1 += beta2/MAXPLACEHOLDER
        beta2 -= (beta2/MAXPLACEHOLDER)*MAXPLACEHOLDER
    }
 
/*
    func splitNumber(number1 : CUnsignedLongLong, number2 : CUnsignedLongLong) -> Void {
        
        var num1 : CUnsignedLongLong = number1
        var num2 : CUnsignedLongLong = number2
        
        num1 += num2/MAXPLACEHOLDER
        num2 -= ((num2/MAXPLACEHOLDER)*MAXPLACEHOLDER)
    }
*/
    
    // MARK:  UITableViewDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 100000 //Scrolls far enough
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: cellIdentifier)
        }        
        
        let row = indexPath.row

        self.appendFib()
        
  //      cell!.textLabel?.text = String(numbers[row])
        // cell!.textLabel?.text = String(format: "1 %ull" ,numbers[row])
       
            if(numbers1[row] > 0){
           // cell!.textLabel?.text = String(format: "%g%04g", arguments: numbers1[row],numbers2[row])
            //cell!.textLabel?.text = String(format: "%g", arguments: numbers1[row])
               // cell!.textLabel?.text = String("\(numbers1[row])\(numbers2[row])")
            //println(NSString(format:"%02i", i))
            //println(String(format: "a float number: %.5f", 1.0321))
            //cell!.textLabel?.text = NSString(format: "%ll%04ll", numbers1[row],numbers2[row]) as String
            cell!.textLabel?.text = String(NSString(format: "\(numbers1[row])%019llu", numbers2[row]))
            //"%04llu"
            
            } else {
                cell!.textLabel?.text = String(numbers2[row])
                }
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println("numbers1: \(numbers1[row])")
        println("numbers2: \(numbers2[row])")
    }
}