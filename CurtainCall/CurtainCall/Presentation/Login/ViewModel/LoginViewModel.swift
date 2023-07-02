//
//  LoginViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/26.
//

import Foundation
import AuthenticationServices
import Combine

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

import FacebookLogin

import GoogleSignIn

protocol LoginViewModelInput {
    func requestLogin(crendential: ASAuthorizationAppleIDCredential?, error: Error?)
    func requestLogin(oauthToken: OAuthToken?, error: Error?)
    func requestLogin(result: LoginManagerLoginResult?, error: Error?)
}

protocol LoginViewModelOutput {
    var loginPublisher: PassthroughSubject<LoginType, Error> { get set }
}

protocol LoginViewModelIO: LoginViewModelInput & LoginViewModelOutput { }

final class LoginViewModel: LoginViewModelIO {
    
    // MARK: - Properties
    
    private let useCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()
    var loginPublisher = PassthroughSubject<LoginType, Error>()
    weak var loginViewController: UIViewController?
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Helpers

    func requestLogin(crendential: ASAuthorizationAppleIDCredential?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        
        if let crendential, let token = crendential.identityToken {
            useCase.loginWithApple(token: token)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(let error):
                        self?.loginPublisher.send(completion: .failure(error))
                        return
                    }
                } receiveValue: { [weak self] token in
                    print(token)
                    self?.loginPublisher.send(.apple)
                }.store(in: &cancellables)
        }
    }
    
    func requestLogin(oauthToken: OAuthToken?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        if let oauthToken {
            useCase.loginWithKakao(token: oauthToken.accessToken)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.loginPublisher.send(completion: .failure(error))
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] token in
                    print(token)
                    self?.loginPublisher.send(.kakao)
                }.store(in: &cancellables)
            
        }
    }
    
    func requestLogin(result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        
        if let result, let token = result.token?.tokenString {
            useCase.loginWithFacebook(token: token)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.loginPublisher.send(completion: .failure(error))
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] token in
                    print(token)
                    self?.loginPublisher.send(.facebook)
                }.store(in: &cancellables)
        }
    }
    
}

extension LoginViewModel {
    private func signInWithGoogle() {
        guard let loginViewController = loginViewController else {
            return
        }
        GIDSignIn.sharedInstance.signIn(withPresenting: loginViewController) { [weak self] result, error in
            if let error {
                self?.loginPublisher.send(completion: .failure(error))
                return
            }
            if let result {
                self?.requestUsecaseToGoogleLogin()
            }
            
        }
    }
    
    private func requestUsecaseToGoogleLogin() {
        useCase.loginWithGoogle()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.loginPublisher.send(completion: .failure(error))
                case .finished:
                    return
                }
            } receiveValue: { [weak self] _ in
                self?.loginPublisher.send(.google)
            }.store(in: &cancellables)
    }
}
