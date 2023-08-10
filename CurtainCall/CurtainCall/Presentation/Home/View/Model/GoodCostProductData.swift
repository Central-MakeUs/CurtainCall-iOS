//
//  GoodCostProductData.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/09.
//

import UIKit

struct GoodCostProductData: Hashable {
    let posterImage: UIImage?
    let title: String
    let average: Double
    let count: Int
    
    static let list: [GoodCostProductData] = [
        GoodCostProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트",
            average: 4.9,
            count: 1021
        ),
        GoodCostProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트2",
            average: 1.2,
            count: 1021
        )
        ,GoodCostProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트3",
            average: 3.5,
            count: 24
        )
        ,GoodCostProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트4",
            average: 4.4,
            count: 1324
        )
        ,GoodCostProductData(
            posterImage: UIImage(named: "dummy_poster"),
            title: "데스노트5",
            average: 4.9,
            count: 123
        )
    ]
    
}
