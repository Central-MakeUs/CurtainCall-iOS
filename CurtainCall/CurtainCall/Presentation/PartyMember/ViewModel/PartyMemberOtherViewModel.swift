//
//  PartyMemberOtherViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation
import Combine

final class PartyMemberOtherViewModel {
    
    // MARK: - Properties
    
    private let usecase: PartyMemberOtherUsecase
    private var cancellables = Set<AnyCancellable>()
    var otherInfoData = PassthroughSubject<[OtherPartyInfo], Error>()
    
    // MARK: - Lifecycles
    
    init(usecase: PartyMemberOtherUsecase) {
        self.usecase = usecase
    }

    // MARK: - Helpers
    
    func requestPartyProductInfo() {
        usecase.execute().sink { [weak self] completion in
            if case let .failure(error) = completion {
                self?.otherInfoData.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] data in
            self?.otherInfoData.send(data)
        }.store(in: &cancellables)
    }
    
}

