//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Ridwan Al-Mansur on 02/02/2016.
//  Copyright © 2016 Ridwan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Addition = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    var runningNumber: String = ""
    var leftValStr: String = ""
    var rightValStr: String = ""
    var currentOperation: Operation = Operation.Empty
    var result: String = ""
    
    @IBOutlet weak var outputLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Assign audio for button
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: ".wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(btn: UIButton) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = "\(runningNumber)"
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Addition)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                switch currentOperation {
                case .Addition:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                case .Subtract:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                case .Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                case .Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                default: break
                }
                leftValStr = result
                outputLbl.text = result
            }
            currentOperation = op
        } else {
            // First time operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
    
}












