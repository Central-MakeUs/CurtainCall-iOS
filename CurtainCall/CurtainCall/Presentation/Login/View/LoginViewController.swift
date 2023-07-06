//
//  LoginViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/26.
//

import UIKit
import Combine
import AuthenticationServices

import SnapKit
import GoogleSignIn
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import FacebookLogin
import GoogleSignIn

final class LoginViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = -8
        return stackView
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.loginButtonKakao), for: .normal)
        return button
    }()
    
    private let googleLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.loginButtonGoogle), for: .normal)
        return button
    }()
    
    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.loginButtonFacebook), for: .normal)
        return button
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.loginButtonApple), for: .normal)
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.splashLogo)
        return imageView
    }()
    
    private let loginStart: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.loginStart)
        return imageView
    }()
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycles
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.loginViewController = self
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        addTargets()
    }
    
    private func configureSubviews() {
        view.backgroundColor = UIColor(rgb: 0x273041)
        [loginButtonStackView, logoImageView, loginStart].forEach { view.addSubview($0) }
        [kakaoLoginButton, googleLoginButton, facebookLoginButton, appleLoginButton].forEach {
            loginButtonStackView.addArrangedSubview($0)
        }
    }
    
    private func configureConstraints() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }
        loginStart.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(100)
        }
        loginButtonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginStart.snp.bottom).offset(14)
        }
    }
    
    private func addTargets() {
        [kakaoLoginButton, googleLoginButton, facebookLoginButton, appleLoginButton].forEach {
            $0.addTarget(self, action: #selector(loginButtonTouchUpInside), for: .touchUpInside)
        }
    }
    
    private func bind() {
        viewModel.loginPublisher
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("끝남 처리")
                }
            } receiveValue: { loginType in
                _ = loginType
                // TODO: 홈으로 넘길지, 약관동의 화면으로 넘길지 확인
                
                // 홈
                
                // 회원가입
                let termOfserviceViewController = TermsOfServiceViewController()
                self.navigationController?.pushViewController(
                    termOfserviceViewController,
                    animated: true
                )
                
//                switch loginType {
//                case .apple:
//                    print("애플 로그인 성공")
//                case .kakao:
//                    print("카카오 로그인 성공")
//                case .facebook:
//                    print("페이스북 로그인 성공")
//                case .google:
//                    print("구글 로그인 성공")
//                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Action
    
    @objc
    private func loginButtonTouchUpInside(_ sender: UIButton) {
        switch sender {
        case appleLoginButton:
            signInWithApple()
        case kakaoLoginButton:
            signInWithKakao()
        case facebookLoginButton:
            signInWithFacebook()
        case googleLoginButton:
            signInWithGoogle()
        default:
            fatalError("Invalid Button")
        }
        
    }
}

// MARK: Apple Login

extension LoginViewController: ASAuthorizationControllerDelegate {
    func signInWithApple() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        viewModel.requestLogin(crendential: credential, error: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        viewModel.requestLogin(crendential: nil, error: error)
    }
}

// MARK: Kakao Login

extension LoginViewController {
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
            self?.viewModel.requestLogin(oauthToken: oauthToken, error: error)
        }
    }
    
    /// 카카오 웹뷰로 로그인
    private func kakaoLoginToWebView() {
        UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
            self?.viewModel.requestLogin(oauthToken: oauthToken, error: error)
        }
    }
}

// MARK: Facebook Login

extension LoginViewController {
    private func signInWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [], from: self) { [weak self] result, error in
            self?.viewModel.requestLogin(result: result, error: error)
        }
            
    }
}

// MARK: Google Login

extension LoginViewController {
    private func signInWithGoogle() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            self?.viewModel.requestLogin(result: result, error: error)
            
        }
    }
}
