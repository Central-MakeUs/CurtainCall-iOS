//
//  PartyMemberOtherUsecase.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation
import Combine

protocol PartyMemberOtherUsecase {
    func execute() -> AnyPublisher<[OtherPartyInfo], Error>
}

final class PartyMemberOtherInteractor: PartyMemberOtherUsecase {
    func execute() -> AnyPublisher<[OtherPartyInfo], Error> {
        return Future<[OtherPartyInfo], Error> { promise in
            promise(.success(OtherPartyInfo.list))
        }.eraseToAnyPublisher()
    }
    
}
