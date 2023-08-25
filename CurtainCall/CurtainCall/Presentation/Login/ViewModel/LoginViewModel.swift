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
import FacebookLogin
import GoogleSignIn
import Moya
import CombineMoya
import SwiftKeychainWrapper

protocol LoginViewModelInput {
    func requestLogin(crendential: ASAuthorizationAppleIDCredential?, error: Error?)
    func requestLogin(oauthToken: OAuthToken?, error: Error?)
    func requestLogin(result: LoginManagerLoginResult?, error: Error?)
    func requestLogin(result: GIDSignInResult?, error: Error?)
}

protocol LoginViewModelOutput {
    var loginPublisher: PassthroughSubject<(LoginType, Int?), Error> { get set }
}

protocol LoginViewModelIO: LoginViewModelInput & LoginViewModelOutput { }

final class LoginViewModel: LoginViewModelIO {
    
    // MARK: - Properties
    
    private let useCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()
    private let loginProvider = MoyaProvider<LoginAPI>()
    var loginPublisher = PassthroughSubject<(LoginType, Int?), Error>()
    weak var loginViewController: UIViewController?
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Helpers
    
    func requestLogin(crendential: ASAuthorizationAppleIDCredential?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        
        guard let crendential, let token = crendential.identityToken,
        let idToken = String(data: token, encoding: .utf8) else
        {
            return
        }
        print("Apple IdentityToken", String(data: token, encoding: .utf8))
        loginProvider.requestPublisher(.apple(idToken))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.loginPublisher.send(completion: .failure(error))
                case .finished:
                    return
                }
            }, receiveValue: { [weak self] response in
                print("APPLE LOGIN", String(data: response.data, encoding: .utf8))
                if let data = try? response.map(AuthenticationResponse.self) {
                    KeychainWrapper.standard[.accessToken] = data.accessToken
                    KeychainWrapper.standard[.refreshToken] = data.refreshToken
                    
                    print("##AUTH: ", data)
                    self?.loginPublisher.send((.apple, data.memberId))
                    
                }
            }).store(in: &self.cancellables)
    }
    
    func requestLogin(oauthToken: OAuthToken?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        if let oauthToken {
            self.loginProvider.requestPublisher(.kakao(oauthToken.accessToken))
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    switch completion {
                    case .failure(let error):
                        self.loginPublisher.send(completion: .failure(error))
                    case .finished:
                        return
                    }
                }, receiveValue: { [weak self] response in
                    if let data = try? response.map(AuthenticationResponse.self) {
                        KeychainWrapper.standard[.accessToken] = data.accessToken
                        KeychainWrapper.standard[.refreshToken] = data.refreshToken
                        
                        print("##AUTH: ", data)
                        self?.loginPublisher.send((.kakao, data.memberId))
                        
                    }
                }).store(in: &self.cancellables)
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
                    self?.loginPublisher.send((.facebook, nil))
                }.store(in: &cancellables)
        }
    }
    
    func requestLogin(result: GIDSignInResult?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        
        if let result {
            useCase.loginWithGoogle(token: result.user.accessToken.tokenString)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.loginPublisher.send(completion: .failure(error))
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] token in
                    print(token)
                    self?.loginPublisher.send((.google, nil))
                }.store(in: &cancellables)
        }
    }
    
    
}
