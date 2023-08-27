//
//  LoginCompleteViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/16.
//

import Foundation
import Combine

import Moya
import CombineMoya
import SwiftKeychainWrapper

final class LoginCompleteViewModel {
    
    private let signupProvider = MoyaProvider<SignUpAPI>()
    private var cancellables: Set<AnyCancellable> = []
    var isSuccessSignUp = PassthroughSubject<Bool, Error>()
    
    func signUpButtonTapped(nickname: String) {
        signupProvider.requestPublisher(.signUp(nickname))
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.isSuccessSignUp.send(completion: .failure(error))
                    return
                }
            } receiveValue: { [weak self] response in
                print("#SignUp", String(data: response.data, encoding: .utf8))
                if let data = try? response.map(SignUpResponse.self) {
                    self?.isSuccessSignUp.send(true)
                    KeychainWrapper.standard[.userID] = data.id
                    KeychainWrapper.standard[.isGuestUser] = false
                } else {
                    self?.isSuccessSignUp.send(false)
                }
            }.store(in: &cancellables)

    }
}
