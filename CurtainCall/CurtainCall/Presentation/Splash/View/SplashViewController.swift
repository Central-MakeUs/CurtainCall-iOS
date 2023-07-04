//
//  SplashViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/03.
//

import UIKit

import SnapKit

final class SplashViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.splashLogo)
        imageView.alpha = 0
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Curtain Call"
        label.textColor = UIColor(rgb: 0xFF71A4)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
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
        // TODO: 디자인 컬러 나오면 자주사용하는 색상 따로 빼서 작성
        view.backgroundColor = UIColor(rgb: 0x0340BF)
        configureSubviews()
        configureConstraint()
    }
    
    private func configureSubviews() {
        [logoImageView, appNameLabel].forEach { view.addSubview($0) }
    }
    
    private func configureConstraint() {
        appNameLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(appNameLabel.snp.top).offset(-6)
        }
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 2.0, delay: 1.5, options: .curveEaseOut, animations: {
            self.logoImageView.alpha = 1
        }, completion: { _ in
            // TODO: 자동로그인 확인해서 로그인뷰로 넘길지 메인으로 넘길지, 첫 화면이라면 사용법으로 넘기기
            let usecase = LoginInteractor()
            let loginViewModel = LoginViewModel(useCase: usecase)
            self.changeRootViewController(LoginViewController(viewModel: loginViewModel))
        })
    }
    
    
    
}
