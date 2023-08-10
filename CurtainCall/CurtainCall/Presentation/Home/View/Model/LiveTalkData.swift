//
//  LiveTalkData.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/08.
//

import UIKit

struct LiveTalkData: Hashable {
    let title: String
    let posterImage: UIImage?
    
    static let list: [LiveTalkData] = [
        LiveTalkData(title: "아이좀비", posterImage: UIImage(named: "dummy_poster")),
        LiveTalkData(title: "트레드밀", posterImage: UIImage(named: "dummy_poster")),
        LiveTalkData(title: "겟팅아웃", posterImage: UIImage(named: "dummy_poster")),
        LiveTalkData(title: "백작", posterImage: UIImage(named: "dummy_poster")),
        LiveTalkData(title: "아이좀븨", posterImage: UIImage(named: "dummy_poster")),
        LiveTalkData(title: "몰랄몰라", posterImage: UIImage(named: "dummy_poster")),
        LiveTalkData(title: "트레드르", posterImage: UIImage(named: "dummy_poster"))
    ]
}
