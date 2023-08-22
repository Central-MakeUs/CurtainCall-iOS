//
//  NoticeDetailViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class NoticeDetailViewModel {
    
    private let provider = MoyaProvider<NoticeAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    var noticeDetailInfo = PassthroughSubject<NoticeDetailResponse, Never>()
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func requestDetail() {
        provider.requestPublisher(.detail(id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(NoticeDetailResponse.self) {
                    noticeDetailInfo.send(data)
                } else {
                    print("NOTICE DETAIL ERROR: ")
                }
            }.store(in: &subscriptions)

    }
}
