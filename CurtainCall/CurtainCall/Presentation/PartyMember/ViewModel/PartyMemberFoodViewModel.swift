//
//  PartyMemberFoodViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation
import Combine

final class PartyMemberFoodViewModel {
    
    // MARK: - Properties
    
    private let usecase: PartyMemberFoodUsecase
    private var cancellables = Set<AnyCancellable>()
    var foodInfoData = PassthroughSubject<[FoodPartyInfo], Error>()
    
    // MARK: - Lifecycles
    
    init(usecase: PartyMemberFoodUsecase) {
        self.usecase = usecase
    }

    // MARK: - Helpers
    
    func requestPartyFoodInfo() {
        usecase.execute().sink { [weak self] completion in
            if case let .failure(error) = completion {
                self?.foodInfoData.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] data in
            self?.foodInfoData.send(data)
        }.store(in: &cancellables)
    }
    
}

