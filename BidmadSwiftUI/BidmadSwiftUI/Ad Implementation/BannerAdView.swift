//
//  BannerAdView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/18.
//

import SwiftUI
import OpenBiddingHelper
import Combine

struct BannerAdView: UIViewRepresentable {
    let zoneId: String
    
    func makeUIView(context: Context) -> UIView {
        return context.coordinator.view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(zoneId)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // do nothing
    }
    
    class Coordinator: NSObject, BIDMADOpenBiddingBannerDelegate {
        let ad: BidmadBannerAd
        let view: UIView
        
        var cancellable: AnyCancellable?
        
        init(_ zoneId: String) {
            view = UIView()
            ad = BidmadBannerAd(UIApplication.shared.getCurrentViewController()!, containerView: view, zoneID: zoneId)
            
            super.init()
            
            ad.delegate = self
            
            self.loadAd()
        }
        
        func loadAd() {
            ad.load()
        }
        
        func onLoadAd(_ bidmadAd: OpenBiddingBanner) {
            print("onLoadAd:")
        }
        
        func onLoadFailAd(_ bidmadAd: OpenBiddingBanner, error: Error) {
            print("onLoadFailAd:error: (Received Error: \(error.localizedDescription))")
            
            Task { @MainActor in
                // Retry after 3 seconds
                try! await Task.sleep(nanoseconds: .nanoSeconds(from: 3))
                ad.load()
            }
        }
    }
}
