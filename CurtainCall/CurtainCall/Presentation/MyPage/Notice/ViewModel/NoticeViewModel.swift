//
//  NoticeViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class NoticeViewModel {
    @Published var noticeItem: [NoticeContent] = []
    
    private let provider = MoyaProvider<NoticeAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    
    func requestNotice(page: Int, size: Int) {
        provider.requestPublisher(.basic(page, size))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(NoticeResponse.self) {
                    noticeItem = data.content
                    print("###", noticeItem)
                } else {
                    print("NOTICE ERROR: ")
                }
            }.store(in: &subscriptions)

    }
}
