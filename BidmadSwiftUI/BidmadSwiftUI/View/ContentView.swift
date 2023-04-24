//
//  ContentView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/06.
//

import SwiftUI
import Foundation
import OpenBiddingHelper

struct ContentView: View {
    @StateObject private var interstitialAd = InterstitialAd("228b95a9-6f42-46d8-a40d-60f17f751eb1")
    @StateObject private var rewardedAd = RewardAd("29e1ef67-98d2-47b3-9fa2-9192327dd75d")
    
    var body: some View {
        TabView {
            BannerExampleView()
            .tabItem {
                Image(systemName: "rectangle.bottomthird.inset.filled")
                Text("Banner")
            }
            
            InterstitialExampleView()
                .tabItem {
                    Image(systemName: "rectangle.center.inset.filled")
                    Text("Interstitial")
                }
            
            RewardExampleView()
                .tabItem {
                    Image(systemName: "gift")
                    Text("Reward")
                }
        }
        .environmentObject(interstitialAd)
        .environmentObject(rewardedAd)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
