//
//  BmiCalculator.swift
//  BMI Calculator
//
//  Created by Devesh Avutu on 05/07/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct BmiCalculator {
    var bmi: BMI?
    
    func getBmiValue() -> String {
        return String(format: "%.2f", bmi?.bmiValue ?? 0.0)
    }
    
    func getBmiAdvice() -> String{
        return bmi?.advice ?? "No advice"
    }
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / (height * height)
        let advice: String?
        if bmiValue < 18.5 {
            advice = "Eat more pies"
        } else if bmiValue < 24.5 {
            advice = "Fit as a fiddle!"
        } else {
            advice = "Eat less pies"
        }
        bmi = BMI(bmiValue:bmiValue, advice:advice!)
    }
}
