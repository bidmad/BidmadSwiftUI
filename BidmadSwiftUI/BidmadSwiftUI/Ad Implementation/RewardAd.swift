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
class RewardAd: NSObject, BIDMADOpenBiddingRewardVideoDelegate {
    var isLoaded = false
    
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
    광고를 표시하고 광고가 닫히면 제공된 Handler를 호출합니다.
    - Parameter adClosureHandler: 사용자가 성공적으로 보상을 받았는지 여부를 나타내는 BOOL 값을 매개변수로 사용하는 클로저입니다.
    */
    func show(_ adClosureHandler: ((Bool) -> Void)? = nil) {
        ad.show(on: UIApplication.shared.getCurrentViewController()!)
        self.adClosureHandler = adClosureHandler
        
        // 로드된 광고를 보여줌으로써 로드된 광고가 소진되었습니다. 다음 광고가 로드될 때까지 isLoaded를 false로 설정합니다.
        isLoaded = false
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
