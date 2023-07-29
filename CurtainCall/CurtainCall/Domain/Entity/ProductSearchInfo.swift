//
//  ProductSearchInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/27.
//

import UIKit

struct ProductSearchInfo: Hashable {
    let posterImage: UIImage?
    let title: String
    let grade: Double
    let gradeCount: Int
    let during: String
    let runningTime: String
    let schedule: String
    let subschedule: String
    let location: String
    
    static let list: [ProductSearchInfo] = [
        ProductSearchInfo(
            posterImage: UIImage(named: "dummy_poster1"),
            title: "드림하이",
            grade: 4.8,
            gradeCount: 324,
            during: "2023.6.1 ~ 2023.6.18",
            runningTime: "200분",
            schedule: "화-금 19:00",
            subschedule: "토, 일 14:00, 19:00",
            location: "LG아트센터 서울"
        ),
        ProductSearchInfo(
            posterImage: UIImage(named: "dummy_poster2"),
            title: "비스티",
            grade: 4.2,
            gradeCount: 324,
            during: "2023.6.1 ~ 2023.6.18",
            runningTime: "200분",
            schedule: "화-금 19:00",
            subschedule: "토, 일 14:00, 19:00",
            location: "LG아트센터 서울"
        )
        ,ProductSearchInfo(
            posterImage: UIImage(named: "dummy_poster3"),
            title: "시카고",
            grade: 4.8,
            gradeCount: 324,
            during: "2023.6.1 ~ 2023.6.18",
            runningTime: "200분",
            schedule: "화-금 19:00",
            subschedule: "토, 일 14:00, 19:00",
            location: "LG아트센터 서울"
        )
        ,ProductSearchInfo(
            posterImage: UIImage(named: "dummy_poster5"),
            title: "더 맨 얼라이브, 초이스",
            grade: 4.8,
            gradeCount: 324,
            during: "2023.6.1 ~ 2023.6.18",
            runningTime: "200분",
            schedule: "화-금 19:00",
            subschedule: "토, 일 14:00, 19:00",
            location: "LG아트센터 서울"
        )
        ,ProductSearchInfo(
            posterImage: UIImage(named: "dummy_poster4"),
            title: "고라파더억",
            grade: 4.8,
            gradeCount: 324,
            during: "2023.6.1 ~ 2023.6.18",
            runningTime: "200분",
            schedule: "화-금 19:00",
            subschedule: "토, 일 14:00, 19:00",
            location: "LG아트센터 서울"
        )
    
    ]
}
