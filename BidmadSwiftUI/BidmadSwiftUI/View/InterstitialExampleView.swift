//
//  InterstitialExampleView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/18.
//

import SwiftUI

struct InterstitialExampleView: View {
    @State var ad = InterstitialAd("228b95a9-6f42-46d8-a40d-60f17f751eb1")
    
    var body: some View {
        NavigationStack {
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
