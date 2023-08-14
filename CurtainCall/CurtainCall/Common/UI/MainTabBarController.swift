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
        view.clipsToBounds = true
        return view
    }()
    
    private let tabStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .hexF5F6F8
        return stackView
    }()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarHomeDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarHomeSelected), for: .selected)
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = 0
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    private let productButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarProductDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarProductSelected), for: .selected)
        button.tag = 1
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    private let liveTalkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarLiveTalk), for: .normal)
        button.tag = 2
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    private let emptyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarEmpty), for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    private let partyMemberButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarPartyMemberDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarPartyMemberSelected), for: .selected)
        button.tag = 3
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    private let myPageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarMyPageDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarMyPageSelected), for: .selected)
        button.tag = 4
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    
    private var viewControllers = [
        UINavigationController(rootViewController: HomeViewController()),
        UINavigationController(rootViewController: ProductViewController()), LiveTalkViewController(),
        PartyMemberViewController(),
        UINavigationController(rootViewController: MyPageViewController())
    ]
    
    private var tabbarButtons: [UIButton] = []
    
    // MARK: - Properties
    
    private var selectedIndex = 0
    private var previousIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
        tabbarButtonTapped(tabbarButtons.first ?? UIButton())
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        homeButton.isSelected = true
        tabbarButtons = [
            homeButton, productButton, liveTalkButton, partyMemberButton, myPageButton
        ]
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
    
    private func addTarget() {
        tabbarButtons.forEach {
            $0.addTarget(self, action: #selector(tabbarButtonTapped), for: .touchUpInside)
        }
    }
    
    // MARK: - Action
    
    @objc
    func tabbarButtonTapped(_ sender: UIButton) {
        
        previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        tabbarButtons[previousIndex].isSelected = false
        
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        sender.isSelected = true
        
        let vc = viewControllers[selectedIndex]
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first else { return }
        vc.view.frame = window.frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        self.view.bringSubviewToFront(wholeView)
    }
}
