//
//  BannerData.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/06.
//

import UIKit

struct BannerData: Hashable {
    let title: String
    let description: String
    let icon: UIImage?
    let color: UIColor?
    
    static let list: [BannerData] = [
        BannerData(
            title: "알쏭달쏭 용어 사전",
            description: "연극과 뮤지컬에 관해\n모르는 용어가 있다면?",
            icon: UIImage(named: ImageNamespace.homeBannerDictIcon),
            color: UIColor(rgb: 0xFFE0B2)
        ),
        BannerData(
            title: "티켓팅 안내",
            description: "티켓팅 고수가 되는 방법!",
            icon: UIImage(named: ImageNamespace.homeBannerTikerIcon),
            color: UIColor(rgb: 0xD2D7FF)
        ),
        BannerData(
            title: "할인 꿀팁",
            description: "더 좋은 가격으로 즐기기!",
            icon: UIImage(named: ImageNamespace.homeBannerSaleIcon),
            color: UIColor(rgb: 0xCBF3FF)
        )
    ]
}
