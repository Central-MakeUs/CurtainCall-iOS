//
//  LostItemInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

struct LostItemInfo: Hashable {
    let image: UIImage?
    let name: String
    let getLocation: String
    let keepLocation: String
    let date: Date
    
    static let list: [LostItemInfo] = [
        LostItemInfo(
            image: UIImage(named: "dummy_lost_item1"),
            name: "닥스 지갑",
            getLocation: "LG 아트센터 서울",
            keepLocation: "LG 아트센터 서울",
            date: Date()
        ),
        LostItemInfo(
            image: UIImage(named: "dummy_lost_item2"),
            name: "바이레도 핸드크림",
            getLocation: "LG 아트센터 서울",
            keepLocation: "LG 아트센터 서울",
            date: Date()
        ),
        LostItemInfo(
            image: UIImage(named: "dummy_lost_item3"),
            name: "디올 지갑",
            getLocation: "LG 아트센터 서울",
            keepLocation: "LG 아트센터 서울",
            date: Date()
        ),
        LostItemInfo(
            image: UIImage(named: "dummy_lost_item1"),
            name: "이름모를 지갑",
            getLocation: "미국",
            keepLocation: "한국",
            date: Date()
        ),
        LostItemInfo(
            image: UIImage(named: "dummy_lost_item3"),
            name: "닥스 지갑",
            getLocation: "LG 아트센터 서울",
            keepLocation: "LG 아트센터 서울",
            date: Date()
        )
    ]
}
