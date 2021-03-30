//
//  CalculatorInitialize.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/03/31.
//

import UIKit
import GoogleMobileAds
import AdSupport

extension RealMainViewController{
    
    func Initialize(){
        if ASIdentifierManager.shared().advertisingIdentifier == UUID(uuidString: "BCCF6C2C-ED1B-43F7-B90A-9220D75A19C0"){
            bannerID = "ca-app-pub-3940256099942544/2934735716"
            interstitialAdID = "ca-app-pub-3940256099942544/4411468910"
        }
        else{
            bannerID = "ca-app-pub-5353181976991649/9685965284"
            interstitialAdID = "ca-app-pub-5353181976991649/9930148491"
        }
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)

        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = bannerID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: interstitialAdID,
                               request: request,
                               completionHandler: { [self] ad, error in
                                if let error = error {
                                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                    return
                                }
                                interstitial = ad
                               }
        )
        
        self.calculationButtons = [self.zeroButton, self.oneButton, self.twoButton, self.threeButton, self.fourButton,
                                   self.fiveButton, self.sixButton, self.sevenButton, self.eightButton,
                                   self.nineButton, self.clearButton, self.deleteButton, self.divisionButton,
                                   self.multiplyButton, self.subtractButton, self.plusButton, self.dotButton,
                                   self.resultButton, self.braketButton]
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
}
