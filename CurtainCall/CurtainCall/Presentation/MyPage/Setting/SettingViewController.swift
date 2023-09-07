//
//  SettingViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/23.
//

import UIKit

import SwiftKeychainWrapper

final class SettingViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let accountHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "계정"
        label.font = .body4
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private let logoutView = UIView()
    private let logoutLabel: UILabel = {
        let label = UILabel()
        label.text = "로그아웃"
        label.textColor = .body1
        label.font = .body1
        return label
    }()
    private let logoutButton = UIButton()
    
    private let removeAccoutView = UIView()
    private let removeAccoutLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 삭제"
        label.textColor = .body1
        label.font = .body1
        return label
    }()
    private let removeAccountArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageArrowRight)
        return imageView
    }()
    private let removeAccoutButton = UIButton()
    
    private let infoHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = .body4
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private let privacyPolicyView = UIView()
    private let privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보 처리방침"
        label.textColor = .body1
        label.font = .body1
        return label
    }()
    private let privacyPolicyArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageArrowRight)
        return imageView
    }()
    private let privacyPolicyButton = UIButton()
    
    private let serviceView = UIView()
    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용약관"
        label.textColor = .body1
        label.font = .body1
        return label
    }()
    private let serviceArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageArrowRight)
        return imageView
    }()
    private let serviceButton = UIButton()
    
    private let borderView = BorderView()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubviews(
            accountHeaderLabel, logoutView, removeAccoutView,
            infoHeaderLabel, privacyPolicyView, serviceView, borderView
        )
        logoutView.addSubviews(logoutLabel, logoutButton)
        removeAccoutView.addSubviews(removeAccoutLabel, removeAccountArrowImage, removeAccoutButton)
        privacyPolicyView.addSubviews(privacyPolicyLabel, privacyPolicyArrowImage, privacyPolicyButton)
        serviceView.addSubviews(serviceLabel, serviceArrowImage, serviceButton)
    }
    
    private func configureConstraints() {
        accountHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(31)
            $0.leading.equalToSuperview().offset(24)
        }
        [logoutView, removeAccoutView, privacyPolicyView, serviceView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(48)
                make.horizontalEdges.equalToSuperview()
            }
        }
        [logoutButton, removeAccoutButton, privacyPolicyButton, serviceButton].forEach {
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        [logoutLabel, removeAccoutLabel, privacyPolicyLabel, serviceLabel].forEach {
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(24)
            }
        }
        
        [removeAccountArrowImage, privacyPolicyArrowImage, serviceArrowImage].forEach {
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(24)
            }
        }
        logoutView.snp.makeConstraints {
            $0.top.equalTo(accountHeaderLabel.snp.bottom).offset(7)
        }
        removeAccoutView.snp.makeConstraints {
            $0.top.equalTo(logoutView.snp.bottom)
        }
        borderView.snp.makeConstraints {
            $0.top.equalTo(removeAccoutView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        infoHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
        }
        privacyPolicyView.snp.makeConstraints {
            $0.top.equalTo(infoHeaderLabel.snp.bottom).offset(7)
        }
        serviceView.snp.makeConstraints {
            $0.top.equalTo(privacyPolicyView.snp.bottom)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton(.dismiss)
        title = "설정"
    }
    
    private func addTargets() {
        logoutButton.addTarget(
            self,
            action: #selector(logoutButtonTap),
            for: .touchUpInside
        )
        removeAccoutButton.addTarget(
            self,
            action: #selector(removeAccountButtonTapped),
            for: .touchUpInside
        )
        privacyPolicyButton.addTarget(
            self,
            action: #selector(privacyPolicyButtonTapped),
            for: .touchUpInside
        )
        serviceButton.addTarget(
            self,
            action: #selector(serviceButtonTapped),
            for: .touchUpInside
        )
    }
    
    func logoutPopupPresent() {
        let popup = LogoutPopup()
        popup.delegate = self
        popup.modalPresentationStyle = .overFullScreen
        present(popup, animated: false)
        
    }
    
    @objc
    private func logoutButtonTap() {
        logoutPopupPresent()
    }
    
    @objc
    private func removeAccountButtonTapped() {
        let removeAccountViewController = RemoveAccountViewController(
            viewModel: RemoveAccountViewModel()
        )
        navigationController?.pushViewController(removeAccountViewController, animated: true)
    }
    
    @objc
    private func privacyPolicyButtonTapped() {
        navigationController?.pushViewController(PrivacyPolicyViewController(), animated: true)
    }
    
    @objc
    private func serviceButtonTapped() {
        navigationController?.pushViewController(TermsOfUseViewController(), animated: true)
    }
}

extension SettingViewController: LogoutPopupDelegate {
    func logoutButtonTapped() {
        let loginViewController = LoginViewController(viewModel: LoginViewModel())
        changeRootViewController(UINavigationController(rootViewController: loginViewController))
        KeychainWrapper.standard.remove(forKey: .accessToken)
        KeychainWrapper.standard.remove(forKey: .refreshToken)
        KeychainWrapper.standard.remove(forKey: .userID)
        KeychainWrapper.standard.remove(forKey: .isGuestUser)
        print("logout")
    }
}
