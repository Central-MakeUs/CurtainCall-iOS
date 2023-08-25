//
//  RemoveAccountViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class RemoveAccountViewModel {
    
    private var subscriptions: Set<AnyCancellable> = []
    private let provider = MoyaProvider<RemoveAccountAPI>()
    var reasonDict: [Int: String] = [
        0: "RECORD_DELETION", 1: "INCONVENIENCE_FREQUENT_ERROR", 2: "BETTER_OTHER_SERVICE",
        3: "LOW_USAGE_FREQUENCY", 4: "NOT_USEFUL", 5: "ETC"
    ]

    var isSuccessRemoveAccount = PassthroughSubject<Bool, Never>()
    
    func requestRemoveAccount(body: RemoveAccountBody) {
        provider.requestPublisher(.removeAccount(body: body))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                print("REMOVE ACCOUNT", String(data:response.data, encoding: .utf8))
                if response.statusCode == 200 {
                    self.isSuccessRemoveAccount.send(true)
                } else {
                    self.isSuccessRemoveAccount.send(false)
                }
            }.store(in: &subscriptions)
    }
}
