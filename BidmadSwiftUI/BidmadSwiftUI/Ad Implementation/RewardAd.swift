//
//  InterstitialAdView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/18.
//

import OpenBiddingHelper
import SwiftUI
import Combine

class RewardAd: NSObject, BIDMADOpenBiddingRewardVideoDelegate, ObservableObject {
    @Published var isLoaded = false
    
    private let ad: BidmadRewardAd
    var cancellable: AnyCancellable?
    var isRewarded = false
    var adClosureHandler: ((Bool) -> Void)?
    
    init(_ zoneId: String) {
        ad = BidmadRewardAd(zoneID: zoneId)
        
        super.init()
        
        ad.delegate = self
        ad.load()
    }
    
    /**
    Displays an advertisement and calls the provided closure when the ad is closed.
    - Parameter adClosureHandler: A closure that takes a boolean value as a parameter, indicating whether the user has successfully received a reward or not. If the ad is non-rewarded, the boolean value will always be true.
    */
    func show(_ adClosureHandler: ((Bool) -> Void)? = nil) {
        ad.show(on: UIApplication.shared.getCurrentViewController()!)
        self.adClosureHandler = adClosureHandler
    }
    
    func onLoadAd(_ bidmadAd: OpenBiddingRewardVideo) {
        print("onLoadAd:")
        isLoaded = true
    }
    
    func onLoadFailAd(_ bidmadAd: OpenBiddingRewardVideo, error: Error) {
        print("onLoadFailAd:error: (Received Error: \(error.localizedDescription)")
        isLoaded = false

        Task { @MainActor in
            // Retry after 3 seconds
            try! await Task.sleep(nanoseconds: .nanoSeconds(from: 3))
            ad.load()
        }
    }
    
    func onSkipAd(_ bidmadAd: OpenBiddingRewardVideo) {
        print("onSkipAd:")
        isRewarded = false
    }
    
    func onCompleteAd(_ bidmadAd: OpenBiddingRewardVideo) {
        print("onCompleteAd:")
        isRewarded = true
    }
    
    func onCloseAd(_ bidmadAd: OpenBiddingRewardVideo) {
        print("onCloseAd:")
        adClosureHandler?(isRewarded)
    }
}
