//
//  CalculatorUI.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/03/31.
//

import UIKit
import AVFoundation
import SideMenu
import CoreData

extension RealMainViewController{
    // 실행 메인 함수
    func calculateUIMain(){
        initialize()
        buttonsUIRadius()
        btnAction()
        allClear()
        getAllItems()
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
        resulted = false
        operatorInput = false
    }
    
    // 계산 수식 추가 함수
    func addToCalculateAppend(_ val: String){
        calculates += val
        calculateLabel.text = calculates
        //keyPress()
    }
    
    // 숫자 클릭 시 실행 함수
    func numberBtnAction(_ btn: UIButton!, _ result: String){
        btn.addAction(for: .touchUpInside) { [self] btn in
            if(resulted){
                resulted = false
                allClear()
            }
            addToCalculateAppend(result)
            operatorInput = false
        }
    }
    
    func keyPress(){
        let url = Bundle.main.url(forResource: "ring", withExtension: "wav")
        let sound = try! AVAudioPlayer(contentsOf: url!)
        sound.play()
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
    
    func resultedCharacterClicked(){
        if(resulted){
            resulted = false
            let tempCalculates = resultLabel.text?.replacingOccurrences(of: "=", with: "").trimmingCharacters(in: .whitespaces) ?? ""
            allClear()
            calculateLabel.text = tempCalculates
            calculates = tempCalculates
        }
    }
    
    func realResult(){
        let checkedPercent = calculates.replacingOccurrences(of: "%", with: "*0.01")
        let expression = NSExpression(format: checkedPercent)
        if let result = expression.expressionValue(with: nil, context: nil) as? Double{
            let resultString = calculateResult(result)
            resultLabel.text = "= " + resultString
            resulted = true
            operatorInput = false
            createItem(cal: calculateLabel.text!, result: resultString)
        }
        else{
            MyCustomClass.showAlert(viewController: self, title: "계산값을 초과했습니다.", msg: "계산할 수 있는 양을 초과했기 때문에, 지우고 다시 시작해주세요.", buttonTitle: "지우기") { btn in
                self.allClear()
            }
        }
    }
    
    func getAllItems() {
        do{
            calculateModel = try context.fetch(Calculate.fetchRequest())
            DispatchQueue.main.async {
                self.sideMenu = SideMenuNavigationController(rootViewController:MenuController.init(with: self.calculateModel))
                SideMenuManager.default.leftMenuNavigationController = self.sideMenu
                SideMenuManager.default.addPanGestureToPresent(toView: self.view)
                self.menuController?.tableView.reloadData()
            }
        }
        catch{
            print(error)
        }
    }
    
    func createItem(cal: String, result: String){
        let newItem = Calculate(context: context)
        newItem.calculate = cal
        newItem.resulted = result
        newItem.saveDate = Date()
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            print(error)
        }
    }
    
    @objc func deleteItem(_ notification : Notification){
        
        let item = notification.object as! Calculate
        
        context.delete(item)
        
        do{
            try context.save()
            sideMenu?.dismiss(animated: false, completion: { [self] in
                getAllItems()
                allClear()
            })
        }
        catch{
            print(error)
        }
    }
    
    @objc func getShow(_ notification : Notification){
        let getValue = notification.object as! [String]
        calculateLabel.text = getValue[0]
        resultLabel.text = getValue[1]
        resulted = true
        operatorInput = false
        sideMenu?.dismiss(animated: false, completion: nil)
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
            resultedCharacterClicked()
            if(!calculates.isEmpty){
                calculates.removeLast()
                calculateLabel.text = calculates
            }
        }
        
        // 나누기 버튼
        divisionButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                resultedCharacterClicked()
                addToCalculateAppend("/")
                operatorInput = true
            }
        }
        
        // 곱하기 버튼
        multiplyButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                resultedCharacterClicked()
                addToCalculateAppend("*")
                operatorInput = true
            }
        }
        
        // 빼기 버튼
        subtractButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                resultedCharacterClicked()
                addToCalculateAppend("-")
                operatorInput = true
            }
        }
        
        // 더하기 버튼
        plusButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                resultedCharacterClicked()
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
            //keyPress()
            realResult()
        }
        
        // 괄호 버튼
        braketButton.addAction(for: .touchUpInside) { [self] btn in
            if(!operatorInput){
                resultedCharacterClicked()
                addToCalculateAppend("%")
                operatorInput = true
            }
        }
        
        saveFolder.addAction(for: .touchUpInside) { [self] btn in
            present(sideMenu!, animated: true)
        }
    }
}
