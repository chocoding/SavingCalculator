//
//  DeviceConfig.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/03/30.
//

import UIKit
import SystemConfiguration

class DeviceManager{
    static let shared : DeviceManager = DeviceManager()
    
    var networkStatus: Bool{
        get{
            return checkDeviceNetworkStatus()
        }
    }
    
    private init(){}
    
    private func checkDeviceNetworkStatus() -> Bool {
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            return ret
        }
}

extension UIButton{
    public typealias UIButtonTargetClosure = (UIButton) -> ()
    
    private class UIButtonClosureWrapper: NSObject { let closure: UIButtonTargetClosure
        init(_ closure: @escaping UIButtonTargetClosure) { self.closure = closure } }
    
    private struct AssociatedKeys { static var targetClosure = "targetClosure" }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIButtonClosureWrapper else { return nil }
            return closureWrapper.closure }
        
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIButtonClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) } }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self) }
    
    public func addAction(for event: UIButton.Event, closure: @escaping UIButtonTargetClosure){
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: event)
    }
}
