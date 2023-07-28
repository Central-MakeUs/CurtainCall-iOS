//
//  ReviewInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import Foundation

struct ReviewInfo {
    let nickName: String
    let grade: Double
    let date: Date
    let content: String
    
    static let list: [ReviewInfo] = [
        ReviewInfo(
            nickName: "만도스",
            grade: 3.5,
            date: Date(),
            content: "우와 재밌다"
        ),
        ReviewInfo(
            nickName: "준",
            grade: 0.5,
            date: Date(),
            content: "노잼"
        ),
        ReviewInfo(
            nickName: "저스틴",
            grade: 5,
            date: Date(),
            content: "완전 강추합니다 완전완전"
        ),
        ReviewInfo(
            nickName: "재야",
            grade: 0.5,
            date: Date(),
            content: "별 1개도 아까워요"
        ),
        ReviewInfo(
            nickName: "니카",
            grade: 4,
            date: Date(),
            content: "볼만해요"
        )

    ]
}
