//
//  ViewController.swift
//  calculator
//
//  Created by Hao Lam on 6/8/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currNumber:Double = 0;
    var prevNumber:Double = 0;
    var isEquation = false
    var equation = 0
    var equal_isClicked = false;
    var runningMath:Int = 0;
    
    @IBOutlet weak var prev_calculation: UILabel!
    @IBOutlet weak var result_text: UILabel!
    @IBAction func numbers(_ sender: UIButton) {
        
        if isEquation == true
        {
            result_text.text = String(sender.tag-1)
            currNumber = Double(result_text.text!)!
            isEquation = false
        }
        else
        {
            if equal_isClicked == true
            {
                reset();
                equal_isClicked = false
            }
            result_text.text = result_text.text! + String(sender.tag-1)
            //convert number on-screen to double value
            currNumber = Double(result_text.text!)!
        }
    
       
        
        
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        //check if there is number on-screen and "AC" or "=" button is clicked
        if result_text.text != "" && sender.tag != 15 && sender.tag != 16
        {
            // restore the number on-screen
            if runningMath == 0
            {
            prevNumber = Double(result_text.text!)!
            }
            else
            {
                doMath(equation)
            }
            
            if prev_calculation.text == "Math Error"
            {
                equal_isClicked = true
                result_text.text = "Math Error"
                return
            }
            switch sender.tag
            {
            case 11: // divide
                result_text.text = "/"
                
                break
            case 12: // mutiply
                result_text.text = "*"
                break
            case 13: // minus
                result_text.text = "-"
                break
            case 14: // plus
                result_text.text = "+"
                break
            default:
                break
            }
            
            isEquation = true
            equation = sender.tag //save equation
            runningMath = runningMath + 1
        }
        else if sender.tag == 15
        {
            //" = " is clicked
            switch equation
            {
                case 11: // divide
                    if currNumber==0
                    {
                        // a number cannot divide by 0 => show "error" and reset
                        result_text.text = String ("Math Error")
                        prevNumber = 0
                        currNumber = 0
                        equation = 0
                    }
                    else
                    {
                    result_text.text = String (prevNumber / currNumber)
                    }
                    break
                case 12: // mutiply
                    result_text.text = String (prevNumber * currNumber)
                    break
                case 13: // minus
                    result_text.text = String (prevNumber - currNumber)
                    break
                case 14: // plus
                    result_text.text = String (prevNumber + currNumber)
                    break
                default:
                    break
            }
            equal_isClicked = true
        }
        else if sender.tag == 16
        {
            // "AC" clicked => reset
            reset()
        }
    }
    private func reset()
    {
        result_text.text = ""
        prev_calculation.text = ""
        prevNumber = 0
        currNumber = 0
        equation = 0
        runningMath = 0
    }
    private func doMath(_ op:Int)
    {
        var isError = false
        switch op
        {
            case 11: // divide
                if currNumber==0
                {
                    isError=true
                }
                else
                {
                    prevNumber = prevNumber/currNumber
                }
                break
            case 12: // mutiply
                prevNumber = prevNumber*currNumber
                break
            case 13: // minus
                prevNumber = prevNumber-currNumber
                break
            case 14: // plus
                prevNumber = prevNumber+currNumber
                break
            default:
                break
        }
        if isError == true
        {
            prev_calculation.text = "Math Error"
        }
        else
        {
            prev_calculation.text = String(prevNumber)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

