//
//  ViewController.swift
//  Word Garden
//
//  Created by Chloe Cheng on 9/15/19.
//  Copyright © 2019 Chloe Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }

    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess{
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        //decrements the wrongGuessRemaining and shows the next flower imagin with one less pedal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessRemaining = wrongGuessRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessRemaining)")
        }
        
        let revealedWord = userGuessLabel.text!
        //stop the game if wrongGuessRemaining = 0
        if wrongGuessRemaining == 0 {
            playAgainButton.isHidden = false
            guessLetterButton.isEnabled = false
            guessedLetterField.isEnabled = false
            guessCountLabel.text = "So sorry, you are all out of guesses. Try again?"
        } else if !revealedWord.contains(" _") {
            //you won a game
            playAgainButton.isHidden = false
            guessLetterButton.isEnabled = false
            guessedLetterField.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            //update our guess count
            let guess = (guessCount == 1 ? "guess" : "guesses")
//            var guess = "guesses"
//            if guessCount == 1 {
//                guess = "guess"
//            } else {
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            //disable the button if I dont have a single character in the guessLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        playAgainButton.isHidden = true
        guessLetterButton.isEnabled = false
        guessedLetterField.isEnabled = true
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
    }
    
}
