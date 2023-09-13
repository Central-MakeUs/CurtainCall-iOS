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


