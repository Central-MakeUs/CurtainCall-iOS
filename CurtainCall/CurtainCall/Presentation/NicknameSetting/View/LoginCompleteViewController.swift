//
//  LoginCompleteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit

final class LoginCompleteViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14
        return stackView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.loginCompleteSymbol)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이제 커튼콜 이용을\n시작해볼까요?"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(rgb: 0x273041)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubviews(stackView, startButton)
        stackView.addArrangedSubviews(logoImageView, titleLabel)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(58)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    private func addTarget() {
        startButton.addTarget(
            self,
            action: #selector(startButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    // MARK: - Action
    
    @objc
    func startButtonTouchUpInside() {
        //  TODO: 홈 화면 으로 이동
        print("홈 이동")
        changeRootViewController(MainTabBarController())
    }
}
