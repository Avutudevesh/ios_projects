//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightlabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var bmiCalculator = BmiCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onHeightSliderChanged(_ sender: UISlider) {
        heightLabel.text = "\(String(format: "%.2f", sender.value))m"
    }
    
    @IBAction func onWeightSliderChanged(_ sender: UISlider) {
        weightlabel.text = "\(String(Int(sender.value)))kg"
    }
    
    @IBAction func calculateClicked(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        bmiCalculator.calculateBMI(height: height, weight: weight)
        self.performSegue(withIdentifier: "gotToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotToResults" {
            let destination = segue.destination as! ResultViewController
            destination.bmiResult = bmiCalculator.getBmiValue()
            destination.advice = bmiCalculator.getBmiAdvice()
        }
    }
    
}

