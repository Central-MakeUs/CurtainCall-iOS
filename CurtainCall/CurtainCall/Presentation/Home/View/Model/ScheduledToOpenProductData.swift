//
//  ScheduledToOpenProductData.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/09.
//

import UIKit

struct ScheduledToOpenProductData: Hashable {
    let posterImage: UIImage?
    let title: String
    let average: Double
    let count: Int
    let day: Int
    
    static let list: [ScheduledToOpenProductData] = [
        ScheduledToOpenProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트",
            average: 4.9,
            count: 1021,
            day: 1
        ),
        ScheduledToOpenProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트2",
            average: 1.2,
            count: 1021,
            day: 2
        )
        ,ScheduledToOpenProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트3",
            average: 3.5,
            count: 24,
            day: 3
        )
        ,ScheduledToOpenProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트4",
            average: 4.4,
            count: 1324,
            day: 4
        )
        ,ScheduledToOpenProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트5",
            average: 4.9,
            count: 123,
            day: 5
        )
    ]
    
}
