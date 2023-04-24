//
//  InterstitialAdView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/18.
//

import OpenBiddingHelper
import SwiftUI
import Combine

class InterstitialAd: NSObject, BIDMADOpenBiddingInterstitialDelegate, ObservableObject {
    @Published var isLoaded = false
    
    private let ad: BidmadInterstitialAd
    var cancellable: AnyCancellable?
    var isRewarded = false
    var adClosureHandler: (() -> Void)?
    
    init(_ zoneId: String) {
        ad = BidmadInterstitialAd(zoneID: zoneId)
        
        super.init()
        
        ad.delegate = self
        ad.load()
    }
    
    /**
    Displays an advertisement and calls the provided closure when the ad is closed.
    - Parameter adClosureHandler: A closure that will be called when the ad is closed.
    */
    func show(_ adClosureHandler: (() -> Void)? = nil) {
        ad.show(on: UIApplication.shared.getCurrentViewController()!)
        self.adClosureHandler = adClosureHandler
    }
    
    func onLoadAd(_ bidmadAd: OpenBiddingInterstitial) {
        print("onLoadAd:")
        isLoaded = true
    }

    func onLoadFailAd(_ bidmadAd: OpenBiddingInterstitial, error: Error) {
        print("onLoadFailAd:error: (Received Error: \(error.localizedDescription)")
        isLoaded = false

        Task { @MainActor in
            // Retry after 3 seconds
            try! await Task.sleep(nanoseconds: .nanoSeconds(from: 3))
            ad.load()
        }
    }
    
    func onCloseAd(_ bidmadAd: OpenBiddingInterstitial) {
        print("onCloseAd:")
        adClosureHandler?()
    }
}
