//
//  MyParticipationViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import Foundation
import Combine

import Moya
import CombineMoya
import SwiftKeychainWrapper

final class MyParticipationViewModel {
    
    private let provider = MoyaProvider<MyPageAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    var myParticipationSubject = PassthroughSubject<[MyRecruitmentContent], Never>()
    var page = 0
    
    func requestRecruitment(category: PartyCategoryType) {
        guard let userId = KeychainWrapper.standard.integer(forKey: .userID) else { return }
        provider.requestPublisher(.participations(id: userId, page: page, size: 20, category: category))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyRecruitmentResponse.self) {
                    self?.myParticipationSubject.send(data.content)
                } else {
                    print("ERROR: myParticipationSubject")
                }
            }.store(in: &subscriptions)

    }
}

