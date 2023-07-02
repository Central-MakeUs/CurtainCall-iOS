//
//  LoginUsecase.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/27.
//

import Foundation
import Combine

protocol LoginUseCase {
    func loginWithApple(token: Data) -> AnyPublisher<String, Error>
    func loginWithKakao(token: String) -> AnyPublisher<String, Error>
    func loginWithFacebook(token: String) -> AnyPublisher<String, Error>
    func loginWithGoogle() -> AnyPublisher<Void, Error>
}

final class LoginInteractor: LoginUseCase {
    func loginWithApple(token: Data) -> AnyPublisher<String, Error> {
        
        // TODO: token값 서버로 전달
        
        guard let tokenString = String(data: token, encoding: .utf8) else {
            return Future<String, Error> { promise in
                promise(.failure(LoginError.invalidToken))
            }.eraseToAnyPublisher()
        }
        return Future<String, Error> { promise in
            promise(.success(tokenString))
        }.eraseToAnyPublisher()
        
        
    }
    
    func loginWithKakao(token: String) -> AnyPublisher<String, Error> {
        
        // TODO: token값 서버로 전달
        
        return Future<String, Error> { promise in
            promise(.success(token))
        }.eraseToAnyPublisher()
    }
    func loginWithFacebook(token: String) -> AnyPublisher<String, Error> {
        
        // TODO: token값 서버로 전달
        
        return Future<String, Error> { promise in
            promise(.success(token))
        }.eraseToAnyPublisher()
    }
    
    func loginWithGoogle() -> AnyPublisher<Void, Error> {
        // TODO: 로그인 비즈니스 로직 수행 ex) API 호출
        return Future<Void, Error> { promise in
            promise(.success(print("구글 로그인 성공했을 때, API 요청을 하거나 뭘 하자~")))
        }.eraseToAnyPublisher()
    }
}
