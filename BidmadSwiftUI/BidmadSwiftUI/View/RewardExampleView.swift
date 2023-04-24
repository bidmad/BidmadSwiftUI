//
//  RewardExampleView.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/18.
//

import SwiftUI

struct RewardExampleView: View {
    @State private var isAlertPresented: Bool = false
    @State private var isRewarded: Bool = false
    
    var body: some View {
        CompatibilityNavigationStack {
            VStack {
                Button {
                    isAlertPresented.toggle()
                } label: {
                    Text("리워드 광고 보기")
                }
            }
            .navigationTitle("Reward Example")
            .modifier(RewardAdConfimationAlert(isAlertPresented: $isAlertPresented, isRewarded: $isRewarded))
            .compatibilityNavigationDestination(isPresented: $isRewarded) {
                Text("User is rewarded!")
            }
        }
    }
}

struct RewardAdConfimationAlert: ViewModifier {
    @EnvironmentObject var ad: RewardAd
    
    @Binding var isAlertPresented: Bool
    @Binding var isRewarded: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isAlertPresented {
                GeometryReader { _ in }
                    .background(Color.black.opacity(0.4))
                
                VStack(alignment: .leading) {
                    Image(systemName: "gift")
                    Text("비디오 광고 시청을 완료한 후, 사용자 추가가 가능합니다. 비디오 광고를 시청하시겠습니까?")
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        Button("광고 안 볼래요.") {
                            isAlertPresented.toggle()
                        }
                        .foregroundColor(.red)
                        Spacer()
                        
                        if ad.isLoaded {
                            Button("광고 보여주세요.") {
                                if ad.isLoaded {
                                    ad.show { isRewarded in
                                        guard isRewarded else { return }
                                        
                                        self.isRewarded = true
                                        isAlertPresented = false
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 6)
                            )
                        } else {
                            HStack {
                                Text("광고 로딩 중")
                                    .padding(.trailing, 5)
                                ProgressView()
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                .frame(width: 300, height: 200)
                .modifier(CompatibilityColorGradience(colors: [ .systemBackground ]))
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .shadow(radius: 8)
            }
        }
    }
}

struct RewardExampleView_Previews: PreviewProvider {
    static var previews: some View {
        RewardExampleView()
    }
}
