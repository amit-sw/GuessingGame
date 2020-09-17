//
//  ViewController.swift
//  GuessingGame
//
//  Created by Amit Gupta on 9/5/20.
//  Copyright © 2020 AI Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var nextGuessText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var numberToGuess=0
    var lowRange=0
    var highRange=100
    var totalGuesses=10
    var guessesUsed=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Generate a random number
        generateRandomNumber()
        updateGuessInformation()
        fixupUI()
    }

    @IBAction func submitPressed(_ sender: Any) {
        print("Button pressed with input=",nextGuessText!.text!)
        //UIApplication.shared.sendAction(#selector(self.resignFirstResponder), to:nil, from:nil, for:nil)
        // Read and process the input
        let guessed=Int(nextGuessText!.text!)!
        processGuess(guessed)
        nextGuessText!.text=""
        nextGuessText!.placeholder="Next guess"
        if(guessed != numberToGuess) {
        updateGuessInformation()
        }
    }
    
    func generateRandomNumber() {
        numberToGuess = Int.random(in: lowRange ... highRange)
        print("Generated random number:",numberToGuess)
    }
    
    func processGuess(_ guessedNumber: Int) {
        guessesUsed += 1
        print("Just saw new guess:",guessedNumber," vs. numberToGuess=",numberToGuess)
        if(guessedNumber == numberToGuess) {
            processMatch()
        } else {
            if(guessedNumber<numberToGuess) {
                // Too low
                if(guessedNumber>lowRange) {
                    lowRange=guessedNumber
                }
            } else {
                // Too high
                if(guessedNumber<highRange) {
                    highRange=guessedNumber
                }
            }
            updateGuessInformation()
        }
        return
    }
    
    func processMatch() {
        print("MATCHED!!")
        let successMsg=String(format:"You correctly guessed %d in %d tries",numberToGuess,guessesUsed)
        topText.text=successMsg
        nextGuessText.isHidden=true
        guessCountLabel.isHidden=true
        submitButton.setTitle("Well done!!", for: UIControl.State.normal)
    }
    
    func updateGuessInformation() {
        guessCountLabel.text=String(format:"Tries remaining: %d",totalGuesses-guessesUsed)
        topText.text=String(format:"What is X? \n %d < x < %d",lowRange,highRange)
    }
    
    func fixupUI() {
        submitButton.backgroundColor = .clear
        submitButton.layer.cornerRadius = 25
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.backgroundColor = UIColor.blue
        submitButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
}
