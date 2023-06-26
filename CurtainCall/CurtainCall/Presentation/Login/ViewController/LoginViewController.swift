//
//  LoginViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/26.
//

import UIKit

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
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
    
    // MARK: - Action
    
    @objc
    private func loginButtonTouchUpInside(_ sender: UIButton) {
        // TODO: 로그인 로직 처리
        switch sender.tag {
        case LoginButtonTag.kakaoTag:
            print("kakaoLogin Tapped")
        case LoginButtonTag.naverTag:
            print("naverLogin Tapped")
        case LoginButtonTag.facebookTag:
            print("facebookLogin Tapped")
        case LoginButtonTag.appleTag:
            print("appleLogin Tapped")
        default:
            fatalError("Login Tag invalid")
        }
    }
}
