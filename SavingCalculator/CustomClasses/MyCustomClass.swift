//
//  MyCustomClass.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/04/03.
//

import UIKit

class MyCustomClass
{
    class func showAlert(viewController: UIViewController?,title: String, msg: String, buttonTitle: String, handler: ((UIAlertAction) -> Swift.Void)?){
                
              let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                
              let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
              alertController.addAction(defaultAction)
            
              viewController?.present(alertController, animated: true, completion: nil)
        }
}
