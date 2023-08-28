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
    @Published var recruitmentList: [MyRecruitmentContent] = []
    
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
    
    func requestTop10() {
        let provider = MoyaProvider<HomeAPI>()
        provider.requestPublisher(.top10(type: "DAY", genre: "ALL", baseDate: "2023-08-19"))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
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
                } else {
                    top10ShowList = []
                }
            }.store(in: &subscriptions)
        
    }
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
    
    func requestEnd() {
        let provider = MoyaProvider<HomeAPI>()
        provider.requestPublisher(.end(page: 0, size: 100, endDate: Date().convertToAPIDateYearMonthDayString(), genre: "PLAY"))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(EndShowResponse.self) {
                    let randomEndShowList = data.content.shuffled()
                    
                    if randomEndShowList.count < 10 {
                        endShowList = randomEndShowList
                    } else {
                        endShowList = randomEndShowList.prefix(10).map { $0 }
                    }
                } else {
                    openShowList = []
                }
            }.store(in: &subscriptions)

    }
    
    func requestMyRecuritment() {
        let provider = MoyaProvider<MyPageAPI>()
        guard let userId = KeychainWrapper.standard.integer(forKey: .userID) else { return }
        provider.requestPublisher(.recruitments(id: userId, page: 0, size: 20, category: .watching))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyRecruitmentResponse.self) {
                    self?.recruitmentList.append(contentsOf: data.content)
                } else {
                    print("ERROR: MyRecruitmentError")
                }
            }.store(in: &subscriptions)
        provider.requestPublisher(.recruitments(id: userId, page: 0, size: 20, category: .food))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyRecruitmentResponse.self) {
                    self?.recruitmentList.append(contentsOf: data.content)
                } else {
                    print("ERROR: MyRecruitmentError")
                }
            }.store(in: &subscriptions)
        provider.requestPublisher(.recruitments(id: userId, page: 0, size: 20, category: .etc))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyRecruitmentResponse.self) {
                    self?.recruitmentList.append(contentsOf: data.content)
                } else {
                    print("ERROR: MyRecruitmentError")
                }
            }.store(in: &subscriptions)
    }
    
}
