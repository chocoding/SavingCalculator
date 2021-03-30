//
//  CalculatorUI.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/03/31.
//

import UIKit

extension RealMainViewController{
    func CalculateUIMain(){
        Initialize()
        buttonsUIBording()
    }
    
    func buttonsUIBording(){
        for btns in calculationButtons{
            btns.layer.cornerRadius = 20
            btns.layer.borderWidth = 2
        }
        
        calculateTextView.layer.borderColor = UIColor.white.cgColor
        calculateTextView.layer.borderWidth = 0.5
        calculateTextView.layer.cornerRadius = 10
        resultTextView.layer.borderColor = UIColor.white.cgColor
        resultTextView.layer.borderWidth = 0.5
        resultTextView.layer.cornerRadius = 10
    }
}
