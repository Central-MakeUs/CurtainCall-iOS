//
//  HomeMyProductData.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/07.
//

import UIKit

struct HomeMyProductData: Hashable {
    let posterImage: UIImage?
    let title: String
    let content: String
    let date: Date
    let maxCount: Int
    let minCount: Int
    
    static let list: [HomeMyProductData] = [
        HomeMyProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "시카고",
            content: "공연 끝나고 같이 근처에서 야식",
            date: Date(),
            maxCount: 4,
            minCount: 2
        ),
        HomeMyProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "드림하이",
            content: "같이 볼 사람들~ 모여라~",
            date: Date(),
            maxCount: 4,
            minCount: 3
        ),
    ]
}
