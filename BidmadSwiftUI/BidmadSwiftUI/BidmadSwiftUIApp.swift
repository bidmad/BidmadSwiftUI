//
//  BidmadSwiftUIApp.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/24.
//

import SwiftUI
import OpenBiddingHelper

@main
struct BidmadSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    BidmadCommon.initializeSdk()
                }
        }
    }
}
