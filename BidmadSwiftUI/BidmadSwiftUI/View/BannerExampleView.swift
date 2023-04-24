//
//  BannerExampleView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/18.
//

import SwiftUI

struct BannerExampleView: View {
    var body: some View {
        ZStack {
            CompatibilityNavigationStack {
                VStack {
                    BannerAdView(zoneId: "1c3e3085-333f-45af-8427-2810c26a72fc")
                }
                .navigationTitle("Banner Example")
            }
        }
    }
}

struct BannerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        BannerExampleView()
    }
}
