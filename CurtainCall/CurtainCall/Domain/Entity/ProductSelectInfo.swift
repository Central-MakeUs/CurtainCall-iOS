//
//  ProductSelectInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import UIKit

struct ProductSelectInfo: Hashable {
    let title: String
    let posterImage: UIImage?
    let date: [Date]
    var isSelected: Bool = false
    
    // MARK: - DummyData
    
    static let list: [ProductSelectInfo] = [
        ProductSelectInfo(
            title: "BIRTH",
            posterImage: UIImage(named: "dummy_poster1"),
            date: [Date(), Date(timeInterval: 60, since: Date())]
        ),
        ProductSelectInfo(
            title: "별이 빛나는 밤에",
            posterImage: UIImage(named: "dummy_poster2"),
            date: [Date(), Date(timeInterval: 60*60*24*2 + 60, since: Date())]
        )
        ,ProductSelectInfo(
            title: "테베랜드",
            posterImage: UIImage(named: "dummy_poster3"),
            date: [Date(), Date(timeInterval: 60*60*24*3, since: Date())]
        )
        ,ProductSelectInfo(
            title: "오! 나의 귀신님",
            posterImage: UIImage(named: "dummy_poster4"),
            date: [Date(), Date(timeInterval: 60*60*24*4+3600, since: Date())]
        )
        ,ProductSelectInfo(
            title: "불편한 편의점",
            posterImage: UIImage(named: "dummy_poster5"),
            date: [Date(), Date(timeInterval: 60*60*24*7, since: Date())]
        )
        ,ProductSelectInfo(
            title: "너의 목소리가 들려",
            posterImage: UIImage(named: "dummy_poster6"),
            date: [Date(), Date(timeInterval: 60*60*24*11, since: Date())]
        )
        ,ProductSelectInfo(
            title: "테베랜드2",
            posterImage: UIImage(named: "dummy_poster3"),
            date: [Date(), Date(timeInterval: 60*60*24*5, since: Date())]
        )
        ,ProductSelectInfo(
            title: "별이 빛나는 밤에2",
            posterImage: UIImage(named: "dummy_poster2"),
            date: [Date(), Date(timeInterval: 60*60*24*9, since: Date())]
        )
        ,ProductSelectInfo(
            title: "BIRTH2",
            posterImage: UIImage(named: "dummy_poster1"),
            date: [Date(), Date(timeInterval: 60*60*24, since: Date())]
        )
        ,ProductSelectInfo(
            title: "별이 빛나는 밤에3",
            posterImage: UIImage(named: "dummy_poster2"),
            date: [Date(), Date(timeInterval: 60*60*24*2+7200, since: Date())]
        )
        
    ]
}
