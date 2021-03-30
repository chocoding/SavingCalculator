//
//  ViewController.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/03/30.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool){
        checkDeviceNetworkStatus()
    }
    
    func checkDeviceNetworkStatus(){
        if(DeviceManager.shared.networkStatus){
            let firstVC = UIStoryboard(name: "RealMainViewController", bundle: nil).instantiateViewController(withIdentifier: "RealMainViewController")
            firstVC.modalPresentationStyle = .fullScreen
            present(firstVC, animated: true, completion: nil)
            
        } else {
            let alert: UIAlertController = UIAlertController(title: "네트워크 상태 확인", message: "네트워크가 불안정 합니다.", preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "다시 시도", style: .default, handler: { (ACTION) in
                self.checkDeviceNetworkStatus()
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}
