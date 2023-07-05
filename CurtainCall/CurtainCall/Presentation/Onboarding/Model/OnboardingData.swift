//
//  OnboardingData.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import Foundation

struct OnboardingData: Hashable {
    let title: String
    let description: String
    
    static let list: [OnboardingData] = [
        OnboardingData(
            title: "작품 탐색",
            description: "현재 상연 중인 연극 및\n뮤지컬에 관한 모든 정보를\n확인할 수 있어요."
        ),
        OnboardingData(
            title: "파티원 모집",
            description: "보고 싶은 작품을 다른 사람과\n함께 감상하거나 이야기를 나누며 \n작품을 온전히 즐길 수 있어요."
        ),
        OnboardingData(
            title: "라이브톡",
            description: "당일 상영하는 작품들에 한해\n실시간으로 다른 관람객들과 함께\n이야기를 나눌 수 있어요."
        )
    ]
}
