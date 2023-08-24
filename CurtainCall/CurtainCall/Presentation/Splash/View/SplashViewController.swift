//
//  SplashViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/03.
//

import UIKit

import SnapKit
import SwiftKeychainWrapper

final class SplashViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.splashLogo)
        imageView.alpha = 0
        return imageView
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startAnimation()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .pointColor1
        configureSubviews()
        configureConstraint()
    }
    
    private func configureSubviews() {
        view.addSubview(logoImageView)
    }
    
    private func configureConstraint() {
        logoImageView.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
            self.logoImageView.alpha = 1
        }, completion: { [weak self] _ in
            if KeychainWrapper.standard.bool(forKey: .isFirstUser) == nil {
                self?.pushToOnboardingViewController()
                KeychainWrapper.standard[.isFirstUser] = false
            } else if KeychainWrapper.standard.string(forKey: .refreshToken) == nil ||
                        KeychainWrapper.standard.string(forKey: .accessToken) == nil {
                let loginViewController = LoginViewController(
                    viewModel: LoginViewModel(
                    useCase: LoginInteractor())
                )
                self?.changeRootViewController(UINavigationController(rootViewController: loginViewController))
            } else {
                self?.changeRootViewController(MainTabBarController())
            }
        })
    }
    
    private func pushToOnboardingViewController() {
        let onboardingViewModel = OnboardingViewModel()
        self.changeRootViewController(OnboardingViewController(
            viewModel: onboardingViewModel
        ))
    }
    
    
    
}
