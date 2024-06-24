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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
