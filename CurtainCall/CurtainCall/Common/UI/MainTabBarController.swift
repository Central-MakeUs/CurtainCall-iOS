//
//  MainTabBarController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit

import SnapKit

final class MainTabBarController: UIViewController {
    
    // MARK: - UI properties
    
    private let wholeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let tabStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarHomeSelected), for: .normal)
        return button
    }()
    private let productButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarProductDeselected), for: .normal)
        return button
    }()
    private let emptyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarEmpty), for: .normal)
        return button
    }()
    private let partyMemberButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarPartyMemberDeselected), for: .normal)
        return button
    }()
    private let myPageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarMyPageDeselected), for: .normal)
        return button
    }()
    private let liveTalkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarLiveTalk), for: .normal)
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubviews(wholeView)
        wholeView.addSubviews(tabStackView, liveTalkButton)
        tabStackView.addArrangedSubviews(
            homeButton, productButton, emptyButton, partyMemberButton, myPageButton
        )
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(107)
        }
        tabStackView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(90)
        }
        liveTalkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tabStackView.snp.top).offset(-20)
        }
    }
    
}
