//
//  PartyMemberFoodUsecase.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation
import Combine

protocol PartyMemberFoodUsecase {
    func execute() -> AnyPublisher<[FoodPartyInfo], Error>
}

final class PartyMemberFoodInteractor: PartyMemberFoodUsecase {
    func execute() -> AnyPublisher<[FoodPartyInfo], Error> {
        return Future<[FoodPartyInfo], Error> { promise in
            promise(.success(FoodPartyInfo.list))
        }.eraseToAnyPublisher()
    }
    
}

