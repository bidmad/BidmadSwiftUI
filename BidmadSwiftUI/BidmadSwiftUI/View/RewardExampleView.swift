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
        NavigationStack {
            VStack {
                Button {
                    isAlertPresented.toggle()
                } label: {
                    Text("리워드 광고 보기")
                }
            }
            .navigationTitle("Reward Example")
            .modifier(RewardAdConfimationAlert(isAlertPresented: $isAlertPresented, isRewarded: $isRewarded))
            .navigationDestination(isPresented: $isRewarded) {
                UserRewardView()
            }
        }
    }
}

struct RewardAdConfimationAlert: ViewModifier {
    @State var ad = RewardAd("29e1ef67-98d2-47b3-9fa2-9192327dd75d")
    
    @Binding var isAlertPresented: Bool
    @Binding var isRewarded: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isAlertPresented {
                Color.black.opacity(0.4)
                
                mainContent
                    .padding()
                    .frame(width: 300, height: 200)
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                    .shadow(radius: 8)
            }
        }
        .ignoresSafeArea()
    }
    
    var mainContent: some View {
        VStack(alignment: .leading) {
            Image(systemName: "gift")
            Text("비디오 광고 시청을 마치면 보상이 주어집니다. 비디오 광고를 시청하시겠습니까?")
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
    }
}

struct UserRewardView: View {
    var body: some View {
        HStack {
            Image(systemName: "gift")
            Text("리워드가 준비되었습니다!")
            Image(systemName: "gift")
        }
    }
}

struct RewardExampleView_Previews: PreviewProvider {
    static var previews: some View {
        RewardExampleView()
    }
}
