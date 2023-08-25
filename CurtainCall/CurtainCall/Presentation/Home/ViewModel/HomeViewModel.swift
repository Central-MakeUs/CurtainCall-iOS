//
//  HomeViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation
import Combine

import Moya
import CombineMoya
import SwiftKeychainWrapper

final class HomeViewModel {
    
    private let userInfoProvider = MoyaProvider<MyPageAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    var userInfoSubject = PassthroughSubject<MyPageDetailResponse, Never>()
    @Published var openShowList: [OpenShowContent] = []
    
    func requestUserInfo() {
        guard let userId = KeychainWrapper.standard.integer(forKey: .userID) else {
            print("UserId not exist")
            return
        }
        userInfoProvider.requestPublisher(.detailProfile(id: userId))
            .sink { completion in
                if case let .failure(error) = completion {
                    print("UserInfo Error", error)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyPageDetailResponse.self) {
                    UserInfoManager.shared.userInfo = data
                    self?.userInfoSubject.send(data)
                    print("###", data)
                    return
                } else {
                    print("User Info respone Error")
                    return
                }
            }.store(in: &subscriptions)

    }
    
//    func requestTop10() {
//        let provider = MoyaProvider<HomeAPI>()
//        provider.requestPublisher(.top10(type: <#T##String#>, genre: <#T##ProductListAPI#>, baseDate: <#T##String#>))
//    }
    func requestOpen() {
        let provider = MoyaProvider<HomeAPI>()
        provider.requestPublisher(.open(page: 0, size: 100, startDate: Date().convertToAPIDateYearMonthDayString()))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(OpenShowResponse.self) {
                    let randomOpenShowList = data.content.shuffled()
                    if randomOpenShowList.count < 10 {
                        openShowList = randomOpenShowList
                    } else {
                        openShowList = randomOpenShowList.prefix(10).map { $0 }
                    }
                } else {
                    openShowList = []
                }
            }.store(in: &subscriptions)

    }
}
