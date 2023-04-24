//
//  Utility.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/17.
//

import UIKit

extension UInt64 {
    static func nanoSeconds(from seconds: Int) -> UInt64 {
        return UInt64(seconds) * 1_000_000_000
    }
}

extension UIApplication {
    func getCurrentViewController() -> UIViewController? {
        let keyWindow =
            self.connectedScenes
                .filter({ ($0 as? UIWindowScene) != nil })
                .map({ ($0 as! UIWindowScene).windows })
                .flatMap({ $0 })
                .filter({ $0.isKeyWindow })
                .first
        
        return keyWindow?.rootViewController
    }
}
