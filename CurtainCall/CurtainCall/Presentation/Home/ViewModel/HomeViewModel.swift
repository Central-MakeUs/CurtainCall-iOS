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
    @Published var top10ShowList: [Top10ShowContent] = []
    @Published var endShowList: [EndShowContent] = []
    var isAllRequest = PassthroughSubject<Bool, Never>()
    var recruitmentList = PassthroughSubject<[MyRecruitmentContent], Never>()
    var participationList = PassthroughSubject<[MyRecruitmentContent], Never>()
    @Published var requestCount = 0
    func requestUserInfo() {
        guard let userId = KeychainWrapper.standard.integer(forKey: .userID) else {
            print("UserId not exist")
            requestCount += 1
            return
        }
        userInfoProvider.requestPublisher(.detailProfile(id: userId))
            .sink { completion in
                if case let .failure(error) = completion {
                    print("UserInfo Error", error)
                    self.requestCount += 1
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyPageDetailResponse.self) {
                    UserInfoManager.shared.userInfo = data
                    self?.userInfoSubject.send(data)
                    self?.requestCount += 1
                    print("###", data)
                    return
                } else {
                    print("User Info respone Error")
                    self?.requestCount += 1
                    return
                }
            }.store(in: &subscriptions)
        
    }
    
    func requestTop10() {
        let provider = MoyaProvider<HomeAPI>()
        provider.requestPublisher(.top10(type: "DAY", genre: "ALL", baseDate: Date().convertToAPIDateYearMonthDayString()))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    self.requestCount += 1
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(Top10ShowResponse.self) {
                    if data.content.count < 10 {
                        top10ShowList = data.content
                    } else {
                        top10ShowList = data.content.prefix(10).map { $0 }
                    }
                    self.requestCount += 1
                } else {
                    top10ShowList = []
                    self.requestCount += 1
                }
            }.store(in: &subscriptions)
        
    }
    func requestOpen() {
        let provider = MoyaProvider<HomeAPI>()
        provider.requestPublisher(.open(page: 0, size: 100, startDate: Date().convertToAPIDateYearMonthDayString()))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    self.requestCount += 1
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(OpenShowResponse.self) {
                    let randomOpenShowList = data.content.shuffled()
                    if randomOpenShowList.count < 10 {
                        openShowList = randomOpenShowList.sorted { $0.startDate < $1.startDate }
                    } else {
                        openShowList = randomOpenShowList.prefix(10).map { $0 }.sorted { $0.startDate < $1.startDate }
                    }
                    self.requestCount += 1
                } else {
                    openShowList = []
                    self.requestCount += 1
                }
            }.store(in: &subscriptions)
        
    }
    
    func requestEnd() {
        let provider = MoyaProvider<HomeAPI>()
        provider.requestPublisher(.end(page: 0, size: 100, endDate: Date().convertToAPIDateYearMonthDayString(), genre: "PLAY"))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    self.requestCount += 1
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(EndShowResponse.self) {
                    let randomEndShowList = data.content.shuffled()
                    
                    if randomEndShowList.count < 10 {
                        endShowList = randomEndShowList.sorted { $0.endDate < $1.endDate }
                    } else {
                        endShowList = randomEndShowList.prefix(10).map { $0 }.sorted { $0.endDate < $1.endDate }
                    }
                    self.requestCount += 1
                } else {
                    openShowList = []
                    self.requestCount += 1
                }
            }.store(in: &subscriptions)

    }
    
    func requestMyRecuritment() {
        let provider = MoyaProvider<MyPageAPI>()
        guard let userId = KeychainWrapper.standard.integer(forKey: .userID) else {
            requestCount += 1
            return
        }
        provider.requestPublisher(.recruitments(id: userId, page: 0, size: 20, category: nil))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    self.requestCount += 1
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyRecruitmentResponse.self) {
                    // TODO: 기타 셀 개발 후 구현
                    self?.recruitmentList.send(data.content.filter { $0.category != "ETC" })
                    
                } else {
                    self?.recruitmentList.send([])
                    print("ERROR: MyRecruitmentError")
                }
                self?.requestCount += 1
            }.store(in: &subscriptions)
    }
    
    func requestMyParticipation() {
        let provider = MoyaProvider<MyPageAPI>()
        guard let userId = KeychainWrapper.standard.integer(forKey: .userID) else {
            requestCount += 1
            return
        }
        provider.requestPublisher(.participations(id: userId, page: 0, size: 20, category: nil))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    self.requestCount += 1
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyRecruitmentResponse.self) {
                    // TODO: 기타 셀 개발 후 구현
                    self?.participationList.send(data.content.filter { $0.category != "ETC" })
                } else {
                    self?.participationList.send([])
                    print("ERROR: MyParticipationError")
                }
                self?.requestCount += 1
            }.store(in: &subscriptions)
        

    }
    
}
