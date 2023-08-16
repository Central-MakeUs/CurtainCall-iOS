//
//  NicknameSettingUsecase.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import Foundation
import Combine

protocol NicknameSettingUsecase {
    func isValidNickname(nickname: String) -> AnyPublisher<NicknameValidType, Never>
}

final class NicknameSettingInteractor: NicknameSettingUsecase {
    func isValidNickname(nickname: String) -> AnyPublisher<NicknameValidType, Never> {
        
        // TODO: API 요청 성공시
        let isSuccess = true
        if isSuccess {
            return Future<NicknameValidType, Never> { promise in
                promise(.success(.success))
            }.eraseToAnyPublisher()
        } else {
            return Future<NicknameValidType, Never> { promise in
                promise(.success(.isDuplicated))
            }.eraseToAnyPublisher()
        }
    }
    
    
}
