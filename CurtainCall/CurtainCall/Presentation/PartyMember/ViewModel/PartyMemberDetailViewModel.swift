//
//  PartyMemberDetailViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation
import Combine

final class PartyMemberDetailViewModel {
    
    // MARK: - Properties
    
    private let usecase: PartyMemberProductUsecase
    private var cancellables = Set<AnyCancellable>()
    var productInfoData = PassthroughSubject<[ProductPartyInfo], Error>()
    
    // MARK: - Lifecycles
    
    init(usecase: PartyMemberProductUsecase) {
        self.usecase = usecase
    }

    // MARK: - Helpers
    
    func requestPartyProductInfo() {
        usecase.execute().sink { [weak self] completion in
            if case let .failure(error) = completion {
                self?.productInfoData.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] data in
            self?.productInfoData.send(data)
        }.store(in: &cancellables)
    }
    
}
