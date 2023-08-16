//
//  LoginCompleteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit
import Combine

import Moya
import CombineMoya

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
        button.backgroundColor = .pointColor2
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    // MARK: - Property
    
    private let nickname: String
    private let viewModel: LoginCompleteViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    
    // MARK: - Lifecycles
    
    init(viewModel: LoginCompleteViewModel, nickname: String) {
        self.viewModel = viewModel
        self.nickname = nickname
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
        bind()
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
    
    private func bind() {
        viewModel.isSuccessSignUp
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] isSignUp in
                if isSignUp {
                    self?.changeRootViewController(MainTabBarController())
                } else {
                    // TODO: 회원가입 실패 얼럿
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Action
    
    @objc
    func startButtonTouchUpInside() {
        viewModel.signUpButtonTapped(nickname: nickname)
    }
}
