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
        guard !nickname.contains(" ") else {
            return Future<NicknameValidType, Never> { promise in
                promise(.success(.blank))
            }.eraseToAnyPublisher()
        }
        guard (6...15) ~= nickname.count else {
            return Future<NicknameValidType, Never> { promise in
                promise(.success(.length))
            }.eraseToAnyPublisher()
        }
        guard nickname.isValidRegex("^[0-9a-zA-Zㄱ-ㅎ가-힇]*$") else {
            return Future<NicknameValidType, Never> { promise in
                promise(.success(.invalidForm))
            }.eraseToAnyPublisher()
        }
        
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
