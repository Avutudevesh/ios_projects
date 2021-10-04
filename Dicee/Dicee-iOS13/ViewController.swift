//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceViewOne: UIImageView!
    @IBOutlet weak var diceViewTwo: UIImageView!
    
    

    @IBAction func onRollButtonClicked(_ sender: Any) {
        let diceImages = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour") , #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
        diceViewOne.image = diceImages.randomElement()
        diceViewTwo.image = diceImages.randomElement()
    }
    
}

