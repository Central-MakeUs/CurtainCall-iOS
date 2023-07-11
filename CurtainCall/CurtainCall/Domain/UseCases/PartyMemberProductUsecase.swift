//
//  PartyMemberProductUsecase.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation
import Combine

protocol PartyMemberProductUsecase {
    func execute() -> AnyPublisher<[ProductPartyInfo], Error>
}

final class PartyMemberProductInteractor: PartyMemberProductUsecase {
    func execute() -> AnyPublisher<[ProductPartyInfo], Error> {
        return Future<[ProductPartyInfo], Error> { promise in
            promise(.success(ProductPartyInfo.list))
        }.eraseToAnyPublisher()
    }
    
}
