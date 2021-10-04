//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Devesh Avutu on 05/07/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    

    var bmiResult: String?
    var advice: String?
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = bmiResult
        adviceLabel.text = advice
    }
    

    @IBAction func onReCalculateClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
