//
//  ViewController.swift
//  Calculator
//
//  Created by 赵志超 on 16/1/31.
//  Copyright © 2016年 zhaozhichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userIsInTheMiddleOfTappingANumber = false

    @IBOutlet weak var display: UILabel!

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(userIsInTheMiddleOfTappingANumber){
             display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTappingANumber = true
        
        }
    }

    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTappingANumber = false
        operandStack.append(displayValue)
        print(operandStack)
    }
    
    var displayValue:Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTappingANumber = false
        }
        
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTappingANumber {
            enter()
        }
        
        // closure
        switch operation {
        case "+" : performoperation{ $0 + $1}
        case "−" : performoperation{ $1 - $0}
        case "×" : performoperation{ $0 * $1}
        case "÷" : performoperation{ $1 / $0 }
        case "√" : performoperation{ sqrt($0)}
        default : break
        }
        
    }
    
    
    func performoperation(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
        
    }
    
    //
    private func performoperation(operation: (Double,Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    
    // auto layout
     
    
    // mvc
    
    
}

