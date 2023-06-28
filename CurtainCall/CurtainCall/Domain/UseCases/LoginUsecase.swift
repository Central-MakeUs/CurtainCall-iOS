//
//  LoginUsecase.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/27.
//

import Foundation
import Combine

protocol LoginUseCase {
    func loginWithApple() -> AnyPublisher<Void, Error>
    func loginWithKakao() -> AnyPublisher<Void, Error>
}

final class LoginInteractor: LoginUseCase {
    func loginWithApple() -> AnyPublisher<Void, Error> {
        // TODO: 로그인 비즈니스 로직 수행 ex) API 호출
        return Future<Void, Error> { promise in
            promise(.success(print("애플 로그인 성공했을 때, API 요청을 하거나 뭘 하자~")))
        }.eraseToAnyPublisher()
    }
    
    func loginWithKakao() -> AnyPublisher<Void, Error> {
        // TODO: 로그인 비즈니스 로직 수행 ex) API 호출
        return Future<Void, Error> { promise in
            promise(.success(print("카카오 로그인 성공했을 때, API 요청을 하거나 뭘 하자~")))
        }.eraseToAnyPublisher()
    }
    
    
}
