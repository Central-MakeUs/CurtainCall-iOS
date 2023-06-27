//
//  LoginViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/26.
//

import UIKit
import Combine

import SnapKit

final class LoginViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.loginButtonKakao), for: .normal)
        button.tag = LoginButtonTag.kakaoTag
        return button
    }()
    
    private let naverLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.loginButtonNaver), for: .normal)
        button.tag = LoginButtonTag.naverTag
        return button
    }()
    
    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.loginButtonFacebook), for: .normal)
        button.tag = LoginButtonTag.facebookTag
        return button
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.loginButtonApple), for: .normal)
        button.tag = LoginButtonTag.appleTag
        return button
    }()
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycles
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        view.backgroundColor = .white
        view.addSubview(loginButtonStackView)
        [kakaoLoginButton, naverLoginButton, facebookLoginButton, appleLoginButton].forEach {
            loginButtonStackView.addArrangedSubview($0)
        }
    }
    
    private func configureConstraints() {
        loginButtonStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func addTargets() {
        [kakaoLoginButton, naverLoginButton, facebookLoginButton, appleLoginButton].forEach {
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
                switch loginType {
                case .apple:
                    print("애플 로그인 성공")
                default:
                    print("다른거 성공")
                    
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Action
    
    @objc
    private func loginButtonTouchUpInside(_ sender: UIButton) {
        viewModel.didTappedLoginButton(tag: sender.tag)
    }
}
