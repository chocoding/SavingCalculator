//
//  CalculatorUI.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/03/31.
//

import UIKit

extension RealMainViewController{
    // 실행 메인 함수
    func calculateUIMain(){
        initialize()
        buttonsUIRadius()
        btnAction()
        allClear()
    }
    
    // 계산기 버튼 둥글게 만들기 함수
    func buttonsUIRadius(){
        for btns in calculationButtons{
            btns.layer.cornerRadius = 20
            btns.layer.borderWidth = 2
        }
    }
    
    // 전부 지우기 함수
    func allClear(){
        calculates = ""
        calculateLabel.text = ""
        resultLabel.text = ""
    }
    
    // 계산 수식 추가 함수
    func addToCalculateAppend(_ val: String){
        calculates = calculates + val
        calculateLabel.text = calculates
    }
    
    // 숫자 클릭 시 실행 함수
    func numberBtnAction(_ btn: UIButton!, _ result: String){
        btn.addAction(for: .touchUpInside) { [self] btn in
            addToCalculateAppend(result)
            operatorInput = false
        }
    }
    
    // 계산시, 소수점에 따라 소수점을 추가할 지 아닐 지를 판단하는 함수
    func calculateResult(_ result: Double) -> String{
        if(result.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", result)
        }
        else{
            return String(format: "%.2f", result)
        }
    }
    
    // 버튼 클릭 시 액션 함수
    func btnAction(){
        // 숫자 버튼
        let btns = [zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton,
                    sevenButton, eightButton, nineButton]
        
        for idx in btns.indices{
            numberBtnAction(btns[idx], String(idx))
        }
        
        // 전부 지우기 버튼
        clearButton.addAction(for: .touchUpInside) { [self] btn in
            allClear()
        }
        
        // 하나하나 삭제 버튼
        deleteButton.addAction(for: .touchUpInside) { [self] btn in
            if(!calculates.isEmpty){
                calculates.removeLast()
                calculateLabel.text = calculates
            }
        }
        
        // 나누기 버튼
        divisionButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                addToCalculateAppend("/")
                operatorInput = true
            }
        }
        
        // 곱하기 버튼
        multiplyButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                addToCalculateAppend("*")
                operatorInput = true
            }
        }
        
        // 빼기 버튼
        subtractButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                addToCalculateAppend("-")
                operatorInput = true
            }
        }
        
        // 더하기 버튼
        plusButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                addToCalculateAppend("+")
                operatorInput = true
            }
        }
        
        // .버튼
        dotButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                addToCalculateAppend(".")
                operatorInput = true
            }
        }
        
        // 결과 버튼
        resultButton.addAction(for: .touchUpInside) { [self] btn in
            if(calculateLabel.text!.count <= 0){
                return
            }
            
            let checkedPercent = calculates.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedPercent)
            var result = expression.expressionValue(with: nil, context: nil) as! Double
            if(result > Double.greatestFiniteMagnitude){
                result = Double.greatestFiniteMagnitude
            }
            let resultString = calculateResult(result)
            resultLabel.text = "= " + resultString
        }
        
        // 괄호 버튼
        braketButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                addToCalculateAppend("%")
                operatorInput = true
            }
        }
    }
}
