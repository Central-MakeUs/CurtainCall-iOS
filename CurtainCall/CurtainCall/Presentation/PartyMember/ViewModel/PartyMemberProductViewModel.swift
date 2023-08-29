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
    @Published var productInfoData: [PartyListContent] = []
    private let provider = MoyaProvider<PartyAPI>()
    var page = 0
    var isLoding = false
    
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
                    if page == 0 {
                        productInfoData = data.content
                    } else {
                        productInfoData.append(contentsOf: data.content)
                    }
                    return
                }
                
            }.store(in: &cancellables)
    }
    
}
