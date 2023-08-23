//
//  PartyMemberDetailViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class PartyMemberProductViewModel {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    var productInfoData = PassthroughSubject<[PartyListContent], Error>()
    private let provider = MoyaProvider<PartyAPI>()
    
    // MARK: - Lifecycles

    // MARK: - Helpers
    
    func requestPartyProductInfo(page: Int, size: Int, category: PartyCategoryType) {
        provider.requestPublisher(.list(page: page, size: size, category: category))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(PartyListResponse.self) {
                    productInfoData.send(data.content)
                    return
                } else {
                    productInfoData.send(completion: .failure(NSError(domain: "DecodeError", code: 999)))
                }
                
            }.store(in: &cancellables)
    }
    
}
