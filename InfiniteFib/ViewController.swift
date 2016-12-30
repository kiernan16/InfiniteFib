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
    
    let MAXPLACEHOLDER: CUnsignedLongLong = 10000000000000000000
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
        
            temp1 = fibAlpha
            temp2 = fibBeta
        
       if((CUnsignedLongLong.max - beta1) > alpha1){
        
            fibAlpha = alpha1 + beta1
            fibBeta = alpha2 + beta2
        
            alpha1 = beta1
            alpha2 = beta2
        
            beta2 = fibBeta
            beta1 = fibAlpha
        
            self.splitFib()
            self.splitAlpha()
            self.splitBeta()
       }
        
    }
    
    //Adds Fibonacci number to 'numbers' array
    func appendFib() -> Void {
        
        self.nextFib()
        
        numbers2.append(fibBeta)
        numbers1.append(fibAlpha)
        
    }
    
    
    // MARK:  Split Number Methods
    func splitFib() -> Void {
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
 
    
    // MARK:  UITableViewDelegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 100000 //Scrolls far enough
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: cellIdentifier)
        }
        
        let row = indexPath.row

        self.appendFib()

       
            if(numbers1[row] > 0){

                cell!.textLabel?.text = String(format: "\(numbers1[row])%019llu", numbers2[row])
            
            } else {
                cell!.textLabel?.text = String(numbers2[row])
                }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print("numbers1: \(numbers1[row])")
        print("numbers2: \(numbers2[row])")
    }
}
