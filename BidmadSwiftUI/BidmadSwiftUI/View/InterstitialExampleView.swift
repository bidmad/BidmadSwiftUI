//
//  InterstitialExampleView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/18.
//

import SwiftUI

struct InterstitialExampleView: View {
    @EnvironmentObject var ad: InterstitialAd
    
    var body: some View {
        CompatibilityNavigationStack {
            VStack {
                if ad.isLoaded {
                    Button {
                        ad.show()
                    } label: {
                        Text("전면 광고 보기")
                    }
                } else {
                    HStack {
                        Text("광고 로딩 중")
                            .padding(.trailing, 5)
                        ProgressView()
                    }
                }
            }
            .navigationTitle("Interstitial Example")
        }
    }
}

struct InterstitialExampleView_Previews: PreviewProvider {
    static var previews: some View {
        InterstitialExampleView()
    }
}
