//
//  InterstitialAdView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/18.
//

import OpenBiddingHelper
import SwiftUI
import Combine
import Observation

@Observable
class InterstitialAd: NSObject, BIDMADOpenBiddingInterstitialDelegate {
    var isLoaded = false
    
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
    광고를 표시하고 광고가 닫히면 제공된 Handler를 호출합니다.
    - Parameter adClosureHandler: 광고가 닫힐 때 호출되는 클로저입니다.
    */
    func show(_ adClosureHandler: (() -> Void)? = nil) {
        ad.show(on: UIApplication.shared.getCurrentViewController()!)
        self.adClosureHandler = adClosureHandler
        
        // 로드된 광고를 보여줌으로써 로드된 광고가 소진되었습니다. 다음 광고가 로드될 때까지 isLoaded를 false로 설정합니다.
        isLoaded = false
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
