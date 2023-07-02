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
}

protocol LoginViewModelOutput {
    var loginPublisher: PassthroughSubject<LoginType, Error> { get set }
}

protocol LoginViewModelIO: LoginViewModelInput & LoginViewModelOutput { }

final class LoginViewModel: NSObject, LoginViewModelIO {
    
    // MARK: - Properties
    
    private let useCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()
    var loginPublisher = PassthroughSubject<LoginType, Error>()
    weak var loginViewController: UIViewController?
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
        super.init()
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
}

// MARK: Kakao Login

extension LoginViewModel {
    private func signInWithKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            kakaoLoginToKakaoTalk()
        } else {
            kakaoLoginToWebView()
        }
    }
    
    /// 카카오톡으로 로그인
    private func kakaoLoginToKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
            if let error {
                self?.loginPublisher.send(completion: .failure(error))
                return
            }
            // TODO: oauthToken 처리
            _ = oauthToken
            self?.requestUsecaseToKakaoLogin()
        }
    }
    
    /// 카카오 웹뷰로 로그인
    private func kakaoLoginToWebView() {
        UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
            if let error {
                self?.loginPublisher.send(completion: .failure(error))
                return
            }
            // TODO: oauthToken 처리
            _ = oauthToken
            self?.requestUsecaseToKakaoLogin()
        }
    }
    
    private func requestUsecaseToKakaoLogin() {
        useCase.loginWithKakao()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.loginPublisher.send(completion: .failure(error))
                case .finished:
                    return
                }
            } receiveValue: { [weak self] _ in
                self?.loginPublisher.send(.kakao)
            }.store(in: &cancellables)
    }
}

// MARK: Facebook Login

extension LoginViewModel {
    private func signInWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [], from: nil) { [weak self] result, error in
            if let error {
                self?.loginPublisher.send(completion: .failure(error))
                return
            }
            if let result, let token = result.token {
                print(token.userID)
                self?.requestUsecaseToFacebookLogin()
            }
        }
    }
    
    private func requestUsecaseToFacebookLogin() {
        useCase.loginWithFacebook()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.loginPublisher.send(completion: .failure(error))
                case .finished:
                    return
                }
            } receiveValue: { [weak self] _ in
                self?.loginPublisher.send(.facebook)
            }.store(in: &cancellables)
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
