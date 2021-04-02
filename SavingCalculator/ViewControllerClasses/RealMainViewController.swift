//
//  RealMainViewController.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/03/30.
//

import UIKit
import GoogleMobileAds

class RealMainViewController : UIViewController
{
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var braketButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var calculateLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    // variable
    
    var calculationButtons: [UIButton] = [UIButton]()
    
    var calculates = ""
    var interstitial: GADInterstitialAd?
    var bannerView: GADBannerView!
    var bannerID = ""
    var interstitialAdID = ""
    var operatorInput = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateUIMain()
    }
}
