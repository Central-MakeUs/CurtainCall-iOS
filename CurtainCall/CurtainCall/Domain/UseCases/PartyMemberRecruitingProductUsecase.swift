//
//  PartyMemberRecruitingProductUsecase.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import Foundation
import Combine

protocol PartyMemberRecruitingProductUsecase {
    func execute() -> AnyPublisher<[ProductSelectInfo], Error>
}

final class PartyMemberRecruitingProductInteractor: PartyMemberRecruitingProductUsecase {
    func execute() -> AnyPublisher<[ProductSelectInfo], Error> {
        return Future<[ProductSelectInfo], Error> { promise in
            promise(.success(ProductSelectInfo.list))
        }.eraseToAnyPublisher()
    }
    
    
}
