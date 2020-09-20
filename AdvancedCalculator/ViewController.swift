//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var numberString: String = ""
    private var isFinishedTypingNumber: Bool = false
    private var isDecimalButtonClicked: Bool = false
    private var acceptedSign: String = ""
    
    private var numberArray = [Double]()
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a double")
            }
            return number
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        let numberInDouble = displayValue
        isDecimalButtonClicked = false
        numberArray.append(numberInDouble)
        displayLabel.text = ""
        numberString = ""
        casesForSwitch(sender: sender, numberToBeChecked: numberInDouble, numberArray: numberArray)
    
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            if sender.currentTitle == "." {
                sender.isEnabled = true
                if isDecimalButtonClicked {
                    sender.isEnabled = false
                    return
                    
                } else {
                    sender.isEnabled = true
                    isDecimalButtonClicked = true
                }
            }
            numberString.append(contentsOf: numValue)
            displayLabel.text = numberString
        }
        
    }
    
    func casesForSwitch(sender: UIButton, numberToBeChecked: Double, numberArray: [Double]) {
        
        switch sender.currentTitle {
        case "+/-":
            displayLabel.text = String(numberToBeChecked * -1)
        case "AC":
            displayLabel.text = "0"
            numberString = ""
            self.numberArray = [Double]()
            isFinishedTypingNumber = true
        case "%":
            numberString = ""
            isFinishedTypingNumber = true
            displayLabel.text = String(numberToBeChecked / 100)
        case "+":
            acceptedSign = "+"
        case "-":
            acceptedSign = "-"
        case "×":
            acceptedSign = "*"
        case "÷":
            acceptedSign = "/"
        case "=":
            performOperation(acceptedOperation: acceptedSign)
        case .none:
            print("none")
        case .some(_):
            print("some")
        }
    }
    
    func performOperation(acceptedOperation: String) {
        var changedNumber = 0.0
        
        switch acceptedOperation {
        case "+":
            for number in numberArray {
                changedNumber += number
            }
            commonOperations(result: changedNumber)
        case "-":
            changedNumber = numberArray[0] - numberArray[1]
            if numberArray.count > 2 {
                for i in 2...numberArray.count-1 {
                    changedNumber -= numberArray[i]
                }
            }
            commonOperations(result: changedNumber)
        case "*":
            changedNumber = numberArray[0] * numberArray[1]
            if numberArray.count > 2 {
                for i in 2...numberArray.count-1 {
                    changedNumber *= numberArray[i]
                }
            }
            commonOperations(result: changedNumber)
        case "/":
            changedNumber = numberArray[0] / numberArray[1]
            if numberArray.count > 2 {
                for i in 2...numberArray.count-1 {
                    changedNumber /= numberArray[i]
                }
            }
            commonOperations(result: changedNumber)
        default:
            print("default operation")
        }
    }
    
    func commonOperations(result: Double) {
        displayLabel.text = String(result)
        numberArray.removeAll()
    }

}

