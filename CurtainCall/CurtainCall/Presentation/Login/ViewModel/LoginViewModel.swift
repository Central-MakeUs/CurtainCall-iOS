//
//  LoginViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/26.
//

import Foundation
import AuthenticationServices
import Combine

protocol LoginViewModelInput {
    func didTappedLoginButton(tag: Int)
}

protocol LoginViewModelOutput {
    var loginPublisher: PassthroughSubject<LoginType, Error> { get set }
}

protocol LoginViewModelIO: LoginViewModelInput & LoginViewModelOutput { }

final class LoginViewModel: NSObject, ObservableObject, LoginViewModelIO {
    
    // MARK: - Properties

    private let useCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()
    var loginPublisher = PassthroughSubject<LoginType, Error>()
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
        super.init()
    }
    
    // MARK: - Helpers

    func didTappedLoginButton(tag: Int) {
        switch tag {
        case LoginButtonTag.kakaoTag:
            return
        case LoginButtonTag.naverTag:
            return
        case LoginButtonTag.facebookTag:
            return
        case LoginButtonTag.appleTag:
            signInWithApple()
        default:
            return
        }
    }
}

// MARK: Apple Login

extension LoginViewModel: ASAuthorizationControllerDelegate {
    func signInWithApple() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self

        controller.performRequests()
    }
    
    /// 애플 로그인 성공했을 시 ViewController에게 apple 로그인이라고 알려줌
    /// - Parameters:
    ///   - controller: ASAuthorizationController
    ///   - authorization: ASAuthorization
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        useCase.loginWithApple()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.loginPublisher.send(completion: .failure(error))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] _ in
                self?.loginPublisher.send(.apple)
            }.store(in: &cancellables)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.loginPublisher.send(completion: .failure(error))
    }
}
